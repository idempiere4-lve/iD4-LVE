/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.component;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WEditorPopupMenu;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.util.GridTabDataBinder;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MAccountLookup;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.NamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;

/**
 * ListItem renderer for GridTab list box.
 * @author hengsin
 *
 */
public class GridTabListItemRenderer implements ListitemRenderer, ListitemRendererExt {

	private GridTab gridTab;
	private int windowNo;
	private GridTabDataBinder dataBinder;
	private Map<GridField, WEditor> editors = new HashMap<GridField, WEditor>();

	/**
	 * 
	 * @param gridTab
	 * @param windowNo
	 */
	public GridTabListItemRenderer(GridTab gridTab, int windowNo) {
		this.gridTab = gridTab;
		this.windowNo = windowNo;
		this.dataBinder = new GridTabDataBinder(gridTab);
	}
	
	/**
	 * @param listitem
	 * @param data
	 * @see ListitemRenderer#render(Listitem, Object)
	 */
	public void render(Listitem listitem, Object data) throws Exception {
		Object[] values = (Object[])data;
		int columnCount = gridTab.getTableModel().getColumnCount();
		GridField[] gridField = gridTab.getFields();
		for (int i = 0; i < columnCount; i++) {
			if (!gridField[i].isDisplayed()) {
				continue;
			}
			if (editors.get(gridField[i]) == null)
				editors.put(gridField[i], WebEditorFactory.getEditor(gridField[i], true));
			
			int rowIndex = listitem.getIndex();			
			Listcell cell = null;
			if (rowIndex == gridTab.getCurrentRow() && gridField[i].isEditable(true)) {
				cell = getEditorCell(gridField[i], values[i], i);
				cell.setParent(listitem);
			} else {
				if (gridField[i].getDisplayType() == DisplayType.YesNo) {
					cell = new Listcell("", null);
					cell.setParent(listitem);
					cell.setStyle("text-align:center");
					createReadonlyCheckbox(values[i], cell);
				} else {
					cell = new Listcell(getDisplayText(values[i], i), null);
					cell.setParent(listitem);
				}
			}
			CellListener listener = new CellListener((Listbox) listitem.getParent());
			cell.addEventListener(Events.ON_DOUBLE_CLICK, listener);
		}
	}

	private void createReadonlyCheckbox(Object value, Listcell cell) {
		Checkbox checkBox = new Checkbox();
		if (value != null && "true".equalsIgnoreCase(value.toString()))
			checkBox.setChecked(true);
		else
			checkBox.setChecked(false);
		checkBox.setDisabled(true);
		checkBox.setParent(cell);
	}

	private Listcell getEditorCell(GridField gridField, Object object, int i) {
		Listcell cell = new Listcell("", null);
		WEditor editor = editors.get(gridField);
		if (editor != null)  {
			editor.addValueChangeListener(dataBinder);			
			cell.appendChild(editor.getComponent());
			if (editor.getComponent() instanceof Checkbox) {
				cell.setStyle("text-align:center");
			}
			gridField.addPropertyChangeListener(editor);
			editor.setValue(gridField.getValue());
			WEditorPopupMenu popupMenu = editor.getPopupMenu();
            
            if (popupMenu != null)
            {
            	popupMenu.addMenuListener((ContextMenuListener)editor);
            	cell.appendChild(popupMenu);
            }
		}
		
		return cell;
	}
	
	/**
	 * Detach all editor and optionally set the current value of the editor as cell label.
	 * @param updateCellLabel
	 */
	public void stopEditing(boolean updateCellLabel) {
		for (Entry<GridField, WEditor> entry : editors.entrySet()) {
			if (entry.getValue().getComponent().getParent() != null) {
				if (updateCellLabel) {
					Listcell cell = (Listcell) entry.getValue().getComponent().getParent();
					if (entry.getKey().getDisplayType() == DisplayType.YesNo) {
						cell.setLabel("");
						createReadonlyCheckbox(entry.getValue().getValue(), cell);
					} else {				
						cell.setLabel(getDisplayText(entry.getValue().getValue(), getColumnIndex(entry.getKey())));
					}
				}
				entry.getValue().getComponent().detach();
				entry.getKey().removePropertyChangeListener(entry.getValue());
				entry.getValue().removeValuechangeListener(dataBinder);
			}
		}
	}

	private int getColumnIndex(GridField field) {
		GridField[] fields = gridTab.getFields();
		for(int i = 0; i < fields.length; i++) {
			if (fields[i] == field)
				return i;
		}
		return 0;
	}

	/**
	 * @see ListitemRendererExt#getControls()
	 */
	public int getControls() {
		return DETACH_ON_RENDER;
	}

	/**
	 * @param item
	 * @see ListitemRendererExt#newListcell(Listitem)
	 */
	public Listcell newListcell(Listitem item) {
		ListCell listCell = new ListCell();
		listCell.applyProperties();
		listCell.setParent(item);
		return listCell;
	}

	/**
	 * @param listbox
	 * @see ListitemRendererExt#newListitem(Listbox)
	 */
	public Listitem newListitem(Listbox listbox) {
		ListItem item = new ListItem();
		item.applyProperties();
		return item;
	}

	private String getDisplayText(Object value, int columnIndex)
	{
		if (value == null)
			return "";
		
		GridField[] gridField = gridTab.getFields();
		if (gridTab.getTableModel().getColumnClass(columnIndex).equals(Integer.class))
    	{
    		if (gridField[columnIndex].isLookup())
    		{
    			NamePair namepair = null;
    			if (gridField[columnIndex].getDisplayType() == DisplayType.Account)
    			{
    				MAccountLookup lookup = new MAccountLookup(Env.getCtx(), windowNo);
    				namepair = lookup.get(value);
    			}
    			else
    			{
	    			MLookup lookup = MLookupFactory.get(
	    						Env.getCtx(), windowNo, 0, gridField[columnIndex].getAD_Column_ID(), 
	    						gridField[columnIndex].getDisplayType());
	    					
	    			namepair = lookup.get(value);
    			}
    			if (namepair != null)
    				return namepair.getName();
    			else
    				return "";
    		}
    		else
    			return value.toString();
    	}
    	else if (gridTab.getTableModel().getColumnClass(columnIndex).equals(Timestamp.class))
    	{
    		SimpleDateFormat dateFormat = DisplayType.getDateFormat(DisplayType.Date);
    		return dateFormat.format((Timestamp)value);
    	}
    	else
    		return value.toString();
	}
	
	class CellListener implements EventListener {

		private Listbox _listbox;
		
		public CellListener(Listbox listbox) {
			_listbox = listbox;
		}
		
		public void onEvent(Event event) throws Exception {
			if (Events.ON_DOUBLE_CLICK.equals(event.getName())) {
				Event evt = new Event(Events.ON_DOUBLE_CLICK, _listbox);
				Events.sendEvent(_listbox, evt);
			}
		}
		
	}

	/**
	 * Is renderer initialize
	 * @return boolean
	 */
	public boolean isInitialize() {
		return !editors.isEmpty();
	}

	/**
	 * 
	 * @return active editor list
	 */
	public List<WEditor> getEditors() {
		List<WEditor> editorList = new ArrayList<WEditor>();
		if (!editors.isEmpty())
			editorList.addAll(editors.values());
		
		return editorList;
	}
}
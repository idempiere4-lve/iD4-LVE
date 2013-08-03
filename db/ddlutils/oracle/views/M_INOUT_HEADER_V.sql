DROP VIEW m_inout_header_v;

CREATE OR REPLACE VIEW m_inout_header_v
AS
  SELECT io.ad_client_id,
         io.ad_org_id,
         io.isactive,
         io.created,
         io.createdby,
         io.updated,
         io.updatedby,
         'en_US'                          AS ad_language,
         io.m_inout_id,
         io.issotrx,
         io.documentno,
         io.docstatus,
         io.c_doctype_id,
         io.c_bpartner_id,
         bp.value                         AS bpvalue,
         bp.taxid                         AS bptaxid,
         bp.naics,
         bp.duns,
         oi.c_location_id                 AS org_location_id,
         oi.taxid,
         io.m_warehouse_id,
         wh.c_location_id                 AS warehouse_location_id,
         dt.printname                     AS documenttype,
         dt.documentnote                  AS documenttypenote,
         io.c_order_id,
         io.movementdate,
         io.movementtype,
         bpg.greeting                     AS bpgreeting,
         bp.name,
         bp.name2,
         bpcg.greeting                    AS bpcontactgreeting,
         bpc.title,
         bpc.phone,
         NULLIF(bpc.name, bp.name)        AS contactname,
         bpl.c_location_id,
         l.postal
         || l.postal_add                  AS postal,
         bp.referenceno,
         io.description,
         io.poreference,
         io.dateordered,
         io.volume,
         io.weight,
         io.m_shipper_id,
         io.deliveryrule,
         io.deliveryviarule,
         io.priorityrule,
         COALESCE(oi.logo_id, ci.logo_id) AS logo_id,
         io.ad_orgtrx_id,
         io.ad_user_id,
         io.c_activity_id,
         io.c_bpartner_location_id,
         io.c_campaign_id,
         io.c_charge_id,
         io.chargeamt,
         io.c_invoice_id,
         io.c_project_id,
         io.createconfirm,
         io.createfrom,
         io.createpackage,
         io.dateacct,
         io.dateprinted,
         io.datereceived,
         io.docaction,
         io.dropship_bpartner_id,
         io.dropship_location_id,
         io.dropship_user_id,
         io.freightamt,
         io.freightcostrule,
         io.generateto,
         io.isapproved,
         io.isdropship,
         io.isindispute,
         io.isintransit                   AS m_inout_isintransit,
         io.isprinted,
         io.m_rma_id,
         io.nopackages,
         io.pickdate,
         io.posted,
         io.processed,
         io.processedon,
         io.processing,
         io.ref_inout_id,
         io.reversal_id,
         io.salesrep_id                   AS m_inout_salesrep_id,
         io.sendemail,
         io.shipdate,
         io.trackingno,
         io.user1_id,
         io.user2_id,
         bp.acqusitioncost                AS c_bp_acqusitioncost,
         bp.actuallifetimevalue           AS c_bp_actuallifetimevalue,
         bp.ad_language                   AS c_bp_ad_language,
         bp.ad_orgbp_id                   AS c_bp_ad_orgbp_id,
         bp.ad_org_id                     AS c_bp_ad_org_id,
         bp.bpartner_parent_id            AS c_bp_bpartner_parent_id,
         bp.c_bp_group_id                 AS c_bp_c_bp_group_id,
         bp.c_dunning_id                  AS c_bp_c_dunning_id,
         bp.c_greeting_id                 AS c_bp_c_greeting_id,
         bp.c_invoiceschedule_id          AS c_bp_c_invoiceschedule_id,
         bp.c_paymentterm_id              AS c_bp_c_paymentterm_id,
         bp.created                       AS c_bp_created,
         bp.createdby                     AS c_bp_createdby,
         bp.c_taxgroup_id                 AS c_bp_c_taxgroup_id,
         bp.deliveryrule                  AS c_bp_deliveryrule,
         bp.deliveryviarule               AS c_bp_deliveryviarule,
         bp.description                   AS c_bp_description,
         bp.dunninggrace                  AS c_bp_dunninggrace,
         bp.firstsale                     AS c_bp_firstsale,
         bp.flatdiscount                  AS c_bp_flatdiscount,
         bp.freightcostrule               AS c_bp_freightcostrule,
         bp.invoicerule                   AS c_bp_invoicerule,
         bp.isactive                      AS c_bp_isactive,
         bp.iscustomer                    AS c_bp_iscustomer,
         bp.isdiscountprinted             AS c_bp_isdiscountprinted,
         bp.isemployee                    AS c_bp_isemployee,
         bp.ismanufacturer                AS c_bp_ismanufacturer,
         bp.isonetime                     AS c_bp_isonetime,
         bp.ispotaxexempt                 AS c_bp_ispotaxexempt,
         bp.isprospect                    AS c_bp_isprospect,
         bp.issalesrep                    AS c_bp_issalesrep,
         bp.issummary                     AS c_bp_issummary,
         bp.istaxexempt                   AS c_bp_istaxexempt,
         bp.isvendor                      AS c_bp_isvendor,
         bp.logo_id                       AS c_bp_logo_id,
         bp.m_discountschema_id           AS c_bp_m_discountschema_id,
         bp.m_pricelist_id                AS c_bp_m_pricelist_id,
         bp.numberemployees               AS c_bp_numberemployees,
         bp.paymentrule                   AS c_bp_paymentrule,
         bp.paymentrulepo                 AS c_bp_paymentrulepo,
         bp.po_discountschema_id          AS c_bp_po_discountschema_id,
         bp.po_paymentterm_id             AS c_bp_po_paymentterm_id,
         bp.po_pricelist_id               AS c_bp_po_pricelist_id,
         bp.poreference                   AS c_bp_poreference,
         bp.potentiallifetimevalue        AS c_bp_potentiallifetimevalue,
         bp.rating                        AS c_bp_rating,
         bp.salesrep_id                   AS c_bp_salesrep_id,
         bp.salesvolume                   AS c_bp_salesvolume,
         bp.sendemail                     AS c_bp_sendemail,
         bp.shareofcustomer               AS c_bp_shareofcustomer,
         bp.shelflifeminpct               AS c_bp_shelflifeminpct,
         bp.so_creditlimit                AS c_bp_so_creditlimit,
         bp.socreditstatus                AS c_bp_socreditstatus,
         bp.so_creditused                 AS c_bp_so_creditused,
         bp.so_description                AS c_bp_so_description,
         bp.totalopenbalance              AS c_bp_totalopenbalance,
         bp.updated                       AS c_bp_updated,
         bp.updatedby                     AS c_bp_updatedby,
         bp.url                           AS c_bp_url,
         bpg.ad_org_id                    AS c_greeting_ad_org_id,
         bpg.isactive                     AS c_greeting_isactive,
         bpg.isfirstnameonly,
         bpg.name                         AS c_greeting_name,
         bpl.ad_org_id                    AS c_bp_location_ad_org_id,
         bpl.c_bpartner_id                AS c_bp_location_c_bpartner_id,
         bpl.created                      AS c_bp_location_created,
         bpl.createdby                    AS c_bp_location_createdby,
         bpl.c_salesregion_id,
         bpl.fax                          AS c_bp_location_fax,
         bpl.isactive                     AS c_bp_location_isactive,
         bpl.isbillto,
         bpl.isdn,
         bpl.ispayfrom,
         bpl.isremitto,
         bpl.isshipto,
         bpl.name                         AS c_bp_location_name,
         bpl.phone                        AS c_bp_location_phone,
         bpl.phone2                       AS c_bp_location_phone2,
         bpl.updated                      AS c_bp_location_updated,
         bpl.updatedby                    AS c_bp_location_updatedby,
         l.address1,
         l.address2,
         l.address3,
         l.address4,
         l.ad_org_id                      AS c_location_ad_org_id,
         l.c_city_id,
         l.c_country_id,
         l.city,
         l.created                        AS c_location_created,
         l.createdby                      AS c_location_createdby,
         l.c_region_id,
         l.isactive                       AS c_location_isactive,
         l.regionname,
         l.updated                        AS c_location_updated,
         l.updatedby                      AS c_location_updatedby,
         bpc.ad_org_id                    AS ad_user_ad_org_id,
         bpc.ad_orgtrx_id                 AS ad_user_ad_ad_orgtrx_id,
         bpc.birthday                     AS ad_user_ad_birthday,
         bpc.c_bpartner_id                AS ad_user_c_bpartner_id,
         bpc.c_bpartner_location_id       AS ad_user_c_bpartner_location_id,
         bpc.c_greeting_id                AS ad_user_c_greeting_id,
         bpc.comments                     AS ad_user_comments,
         bpc.created                      AS ad_user_created,
         bpc.createdby                    AS ad_user_createdby,
         bpc.description                  AS ad_user_description,
         bpc.email                        AS ad_user_email,
         bpc.fax                          AS ad_user_fax,
         bpc.isactive                     AS ad_user_isactive,
         bpc.lastcontact                  AS ad_user_lastcontact,
         bpc.lastresult                   AS ad_user_lastresult,
         bpc.phone2                       AS ad_user_phone2,
         bpc.supervisor_id                AS ad_user_supervisor_id,
         bpc.updated                      AS ad_user_updated,
         bpc.updatedby                    AS ad_user_updatedby,
         bpc.value                        AS ad_user_value,
         bpcg.ad_org_id                   AS c_user_greeting_ad_org_id,
         bpcg.isactive                    AS c_user_greeting_isactive,
         bpcg.isfirstnameonly             AS c_user_greeting_isfnameonly,
         bpcg.name                        AS c_user_greeting_name,
         oi.ad_org_id                     AS ad_orginfo_ad_org_id,
         oi.ad_orgtype_id,
         oi.c_calendar_id,
         oi.created                       AS ad_orginfo_created,
         oi.createdby                     AS ad_orginfo_createdby,
         oi.dropship_warehouse_id,
         oi.duns                          AS ad_orginfo_duns,
         oi.email                         AS ad_orginfo_email,
         oi.fax                           AS ad_orginfo_fax,
         oi.isactive                      AS ad_orginfo_isactive,
         oi.m_warehouse_id                AS ad_orginfo_m_warehouse_id,
         oi.parent_org_id,
         oi.phone                         AS ad_orginfo_phone,
         oi.phone2                        AS ad_orginfo_phone2,
         oi.receiptfootermsg,
         oi.supervisor_id,
         oi.updated                       AS ad_orginfo_updated,
         oi.updatedby                     AS ad_orginfo_updatedby,
         wh.ad_org_id                     AS m_warehouse_ad_org_id,
         wh.description                   AS m_warehouse_description,
         wh.isactive                      AS m_warehouse__isactive,
         wh.isdisallownegativeinv,
         wh.isintransit                   AS m_warehouse_isintransit,
         wh.m_warehousesource_id,
         wh.name                          AS m_warehouse_name,
         wh.replenishmentclass,
         wh.separator,
         wh.value                         AS m_warehouse_value
  FROM   m_inout io
         JOIN c_doctype dt
           ON io.c_doctype_id = dt.c_doctype_id
         JOIN c_bpartner bp
           ON io.c_bpartner_id = bp.c_bpartner_id
         LEFT JOIN c_greeting bpg
                ON bp.c_greeting_id = bpg.c_greeting_id
         JOIN c_bpartner_location bpl
           ON io.c_bpartner_location_id = bpl.c_bpartner_location_id
         JOIN c_location l
           ON bpl.c_location_id = l.c_location_id
         LEFT JOIN ad_user bpc
                ON io.ad_user_id = bpc.ad_user_id
         LEFT JOIN c_greeting bpcg
                ON bpc.c_greeting_id = bpcg.c_greeting_id
         JOIN ad_orginfo oi
           ON io.ad_org_id = oi.ad_org_id
         JOIN ad_clientinfo ci
           ON io.ad_client_id = ci.ad_client_id
         JOIN m_warehouse wh
           ON io.m_warehouse_id = wh.m_warehouse_id
;


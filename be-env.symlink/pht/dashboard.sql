CREATE TEMP TABLE tmp_attr_pane_types (
    tmpId integer,
    fld_type_abbrev varchar(2),
    field_type attr_field_type,
    field_name varchar(40),
    forecast_id integer,
    order_type_name varchar(40),
    num_periods smallint,
    flex_fld_id varchar(36)
);

INSERT INTO tmp_attr_pane_types (tmpId, fld_type_abbrev, field_type, field_name, forecast_id, num_periods, flex_fld_id) VALUES

    (  1, 'M', 'MAttr_ItemCode', 'Code', NULL, NULL, NULL),
    (  2, 'M', 'MAttr_ItemDescription', 'Description', NULL, NULL, NULL),
    (  3, 'M', 'MAttr_Product', 'Product', NULL, NULL, NULL),
    (  4, 'M', 'MAttr_ReplacementType', 'Replacement Type', NULL, NULL, NULL),
    (  5, 'M', 'MAttr_ReplacementMaterial', 'Replacement Material', NULL, NULL, NULL),
    (  6, 'M', 'MAttr_SimilarMaterial', 'Similar Material', NULL, NULL, NULL),
    (  7, 'M', 'MAttr_StandardCost', 'Standard Cost', NULL, NULL, NULL),
    ( 10, 'M', 'MAttr_RepairCost', 'Repair Cost', NULL, NULL, NULL),
    ( 13, 'M', 'MAttr_ListPrice', 'List Price', NULL, NULL, NULL),
    (  8, 'M', 'MAttr_DCPlannerCode', 'Planner (DC)', NULL, NULL, NULL),
    ( 11, 'M', 'MAttr_FieldPlannerCode', 'Planner (Field)', NULL, NULL, NULL),
    ( 14, 'M', 'MAttr_SupplyPlannerCode', 'Planner (Supply)', NULL, NULL, NULL),
    (  9, 'M', 'MAttr_CommodityCode', 'Commodity Code', NULL, NULL, NULL),
    ( 12, 'M', 'MAttr_NetworkGroup', 'Network', NULL, NULL, NULL),
    ( 15, 'M', 'MAttr_MaterialGroup', 'Material Group', NULL, NULL, NULL),
    ( 16, 'M', 'MAttr_PlannerGroup', 'Planner Group', NULL, NULL, NULL),
    ( 17, 'M', 'MAttr_ProductLine', 'Product Line', NULL, NULL, NULL),
    ( 18, 'M', 'MAttr_AddDate', 'Added', NULL, NULL, NULL),
    ( 19, 'M', 'MAttr_StartOfSupport', 'Support Started', NULL, NULL, NULL),
    ( 20, 'M', 'MAttr_EndOfProduction', 'Production Ended', NULL, NULL, NULL),
    ( 21, 'M', 'MAttr_EndOfSupport', 'Support Ended', NULL, NULL, NULL),
    ( 22, 'M', 'MAttr_SerialNumberRequired', 'Serial# Required', NULL, NULL, NULL),
    ( 23, 'M', 'MAttr_BarcodeRequired', 'Barcode Required', NULL, NULL, NULL),
    ( 24, 'M', 'MAttr_ManufacturerMaterialCode', 'Mfr Code', NULL, NULL, NULL),
    ( 25, 'M', 'MAttr_Manufacturer', 'Manufacturer', NULL, NULL, NULL),
    ( 26, 'M', 'MAttr_Weight', 'Weight', NULL, NULL, NULL),
    ( 27, 'M', 'MAttr_FlexField', 'Material-FF-Test', NULL, NULL, 'material-test-id'),

    ( 40, 'SS', 'SupplySource_Supplier', 'Supplier', NULL, NULL, NULL),
    ( 41, 'SS', 'SupplySource_LeadTime', 'Lead Time', NULL, NULL, NULL),
    ( 42, 'SS', 'SupplySource_MinOrderQty', 'Min Order Qty', NULL, NULL, NULL),
    ( 43, 'SS', 'SupplySource_MaxOrderQtyPerOrder', 'Min Qty/Order', NULL, NULL, NULL),
    ( 44, 'SS', 'SupplySource_MaxOrderQtyPerDay', 'Min Qty/Day', NULL, NULL, NULL),
    ( 45, 'SS', 'SupplySource_OrderMultiple', 'Order Multiple', NULL, NULL, NULL),
    ( 46, 'SS', 'SupplySource_LastOrderDate', 'Last Order Date', NULL, NULL, NULL),

    ( 60, 'P', 'Planning_SafetyStock', 'Safety Stock', NULL, NULL, NULL),
    ( 61, 'P', 'Planning_Min', 'Min', NULL, NULL, NULL),
    ( 62, 'P', 'Planning_DemandInLeadTime', 'Demand in Lead Time', NULL, NULL, NULL),
    ( 63, 'P', 'Planning_ServiceLevel', 'Service Level', NULL, NULL, NULL),
    ( 64, 'P', 'Planning_MinPOS', 'Min POS', NULL, NULL, NULL),
    ( 65, 'P', 'Planning_MaxPOS', 'Max POS', NULL, NULL, NULL),
    ( 66, 'P', 'Planning_MinServiceLevel', 'Min Service Lvl', NULL, NULL, NULL),
    ( 68, 'P', 'Planning_MinSafetyStock', 'Min SS', NULL, NULL, NULL),
    ( 69, 'P', 'Planning_MaxSafetyStock', 'Max SS', NULL, NULL, NULL),

    ( 80, 'F', 'InventoryBalance', 'Defective Returns (PTD)', 41, NULL, NULL),
    ( 81, 'F', 'CurrentPeriodForecast', 'Sugg Repair Orders', 512, NULL, NULL),
    ( 82, 'F', 'Others_DaysOfSupply', '', NULL, NULL, NULL),
    ( 84, 'F', 'ForecastSum', 'Service Level Forecast Sum-4', 13, 4, NULL),
    ( 85, 'F', 'ForecastAverage', 'Service Level Forecast Avg-4', 13, 4, NULL),
    ( 88, 'F', 'HistorySum', 'Ext Sales Hist Sum-6', 22, 6, NULL),
    ( 89, 'F', 'HistoryAverage', 'Ext Sales Hist Avg-6', 22, 6, NULL)
;

-- A Material Attributes based pane
INSERT INTO dashboard_pane (name, cid, pane_type, column_widths)                    
VALUES ('Material Attributes', 1, 'AttributePane', '{-1, -1, -1}');

INSERT INTO dashboard_widget (dashboard_pane_id, title, col, seq)
SELECT d.id, w.field_name, (w.tmpId - 1) % 3, w.tmpId
  FROM dashboard_pane d
  JOIN tmp_attr_pane_types w ON ( w.fld_type_abbrev = 'M' )
WHERE d.name = 'Material Attributes' AND d.pane_type = 'AttributePane';

INSERT INTO dashboard_attr_field (id, field_type, flex_field_def_id)
SELECT w.id, t.field_type, ffd.ffid
  FROM dashboard_widget w
  JOIN tmp_attr_pane_types t ON (w.seq = t.tmpId)
  LEFT JOIN flex_field_def ffd ON (ffd.ffid = t.flex_fld_id)
WHERE w.dashboard_pane_id = (SELECT id FROM dashboard_pane d
                              WHERE d.name = 'Material Attributes' AND d.pane_type = 'AttributePane');

-- INSERT INTO tmp_attr_pane_types (tmpId, field_type, field_name, forecast_id, num_periods) VALUES

-- Supply Sources
INSERT INTO dashboard_pane (name, cid, pane_type, column_widths)
VALUES ('Supply Sources', 1, 'AttributePane', '{-1, -1, -1, -1}');

-- Insert widgets twice (once for order type = PURCHASE and second time for REPAIR)
INSERT INTO dashboard_widget (dashboard_pane_id, title, col, seq)
SELECT d.id, otype.unnest || ' ' || t.field_name, t.tmpId % 4, t.tmpId * CASE WHEN otype.unnest = 'PUR' THEN 1 ELSE 100 END
  FROM dashboard_pane d
  JOIN tmp_attr_pane_types t ON ( t.fld_type_abbrev = 'SS' )
  JOIN (SELECT unnest(array['PUR', 'RPR'])) otype ON (1=1)
WHERE d.name = 'Supply Sources' AND d.pane_type = 'AttributePane';

INSERT INTO dashboard_attr_field (id, field_type, order_type_name)
SELECT w.id, t.field_type, CASE WHEN w.seq < 100 THEN 'PURCHASE' ELSE 'REPAIR' END
  FROM dashboard_widget w
  JOIN tmp_attr_pane_types t ON (w.seq = t.tmpId  OR w.seq = (t.tmpId * 100))
WHERE w.dashboard_pane_id = (SELECT id FROM dashboard_pane d WHERE d.name = 'Supply Sources' AND d.pane_type = 'AttributePane');

-- Planning
INSERT INTO dashboard_pane (name, cid, pane_type, column_widths)
VALUES ('Planning', 1, 'AttributePane', '{-1, -1, -1}');

-- Insert widgets
INSERT INTO dashboard_widget (dashboard_pane_id, title, col, seq)
SELECT d.id, w.field_name, (w.tmpId - 60)/4, w.tmpId
  FROM dashboard_pane d
  JOIN tmp_attr_pane_types w ON ( w.fld_type_abbrev = 'P' )
WHERE d.name = 'Planning' AND d.pane_type = 'AttributePane';

INSERT INTO dashboard_attr_field (id, field_type)
SELECT w.id, t.field_type
  FROM dashboard_widget w
  JOIN tmp_attr_pane_types t ON (w.seq = t.tmpId)
WHERE w.dashboard_pane_id = (SELECT id FROM dashboard_pane d WHERE d.name = 'Planning' AND d.pane_type = 'AttributePane');


-- Forecasts
INSERT INTO dashboard_pane (name, cid, pane_type, column_widths)                    
VALUES ('Forecasts', 1, 'AttributePane', '{-1, -1, -1}');

-- Insert widgets
INSERT INTO dashboard_widget (dashboard_pane_id, title, col, seq)
SELECT d.id, w.field_name, (w.tmpId - 80) / 4, w.tmpId
  FROM dashboard_pane d
  JOIN tmp_attr_pane_types w ON ( w.fld_type_abbrev = 'F' )
WHERE d.name = 'Forecasts' AND d.pane_type = 'AttributePane';

INSERT INTO dashboard_attr_field (id, field_type, forecast_id, num_periods)
SELECT w.id, t.field_type, t.forecast_id, t.num_periods
  FROM dashboard_widget w
  JOIN tmp_attr_pane_types t ON (w.seq = t.tmpId)
WHERE w.dashboard_pane_id = (SELECT id FROM dashboard_pane d WHERE d.name = 'Forecasts' AND d.pane_type = 'AttributePane');



DROP TABLE tmp_attr_pane_types;


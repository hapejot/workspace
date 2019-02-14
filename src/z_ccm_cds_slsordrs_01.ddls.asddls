@AbapCatalog.sqlViewName: 'ZVCCMSO01'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Custom Code Migration'
define view z_ccm_cds_slsordrs_01 as select from zccm_so_01 {

 //zccm_so_tpl 
 key client, 
 key salesorderuuid, 
 key salesorder, 
 customer, 
 overallstatus  
}
@AbapCatalog.sqlViewName: 'ZD17CDS02'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[D17] 연결편별 잔여 좌석 평균 현황과 항공사 정보'
@Metadata.ignorePropagatedAnnotations: true
define view ZD17_CDS_02
  as select from scarr       as a
    inner join   zd17_01_fix as b on a.carrid = b.carrid
{
  key a.carrid                               as Carrid,
  key b.connid                               as Connid,
      upper(carrname)                        as Name,
      @Semantics.amount.currencyCode: 'Curr_krw'
      b.Amt_krw,

      @Semantics.currencyCode: true
      cast('KRW' as abap.cuky)               as Curr_krw,

      avg( b.Remain_D17 as abap.dec( 16,2) ) as Avg_rem,
      a.url                                  as url_d17
}
group by
  a.carrid,
  b.connid,
  carrname,
  Curr_krw,
  Amt_krw,
  a.url;

@AbapCatalog.sqlViewName: 'ZD17CDS01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[D17] 운항일자별 잔여 좌석 현황'
@Metadata.ignorePropagatedAnnotations: true
define view ZD17_CDS_01
  as select from sflight
{
  key carrid                                 as Carrid,
  key connid                                 as Connid,
  key fldate                                 as Fldate,
      @Semantics.amount.currencyCode: 'FORCURKEY'
      price                                  as forcuram,
      @Semantics.currencyCode: true
      currency                               as forcurkey,

      @Semantics.amount.currencyCode: 'CURR_KRW'
      currency_conversion(
          amount => price,
          source_currency => currency,
          round => 'X',
          target_currency => cast('KRW' as abap.cuky),
          exchange_rate_type => 'M',
          exchange_rate_date => fldate,
          error_handling => 'SET_TO_NULL'
      )                                      as Amt_krw,

      @Semantics.currencyCode: true
      cast('KRW' as abap.cuky)               as Curr_krw,

      planetype                              as Planetype,
      seatsmax                               as Seatsmax,
      seatsocc                               as Seatsocc,
      seatsmax-seatsocc                      as Remain_D17,

      division( seatsocc, seatsmax, 2) * 100 as Percentage
}
where
  currency = 'USD';
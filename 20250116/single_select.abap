FUNCTION z_bc400_d17_connection_get.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  BC400_S_CONNECTION-CARRID
*"     REFERENCE(IV_CONNID) TYPE  BC400_S_CONNECTION-CONNID
*"  EXPORTING
*"     REFERENCE(ES_CONNECTION) TYPE  BC400_S_CONNECTION
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF ES_CONNECTION
    "into es_connection 하면 table의 배열과 요소가 다르기에 오류 발생
    WHERE carrid = iv_carrid AND connid = iv_connid.

  IF sy-subrc = 0 .
    RAISE no_data.
  ENDIF.

ENDFUNCTION.
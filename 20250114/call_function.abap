*&---------------------------------------------------------------------*
*& Report ZD17_0114_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_0114_test.

DATA : gv_result TYPE scarr.

DATA : ga_result TYPE scarr.

CALL METHOD zcl_d17_airplance2=>get_scarr
  EXPORTING
    iv_carrid = 'AA'
  IMPORTING
    es_scar   = gv_result
  EXCEPTIONS
    no_data   = 1
    OTHERS    = 2.
IF sy-subrc <> 0.
* Implement suitable error handling here
  CASE sy-subrc.
    WHEN '1'.
      WRITE : / 'no data'.
    WHEN '2'.
      WRITE : / 'unknown error'.
  ENDCASE.
ELSE.
  WRITE : / gv_result.
ENDIF.
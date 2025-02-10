*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_ALV_S01
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.

  SELECT-OPTIONS : so_carr FOR gs_flight-carrid,
                   so_conn FOR gs_flight-connid.

SELECTION-SCREEN END OF BLOCK b1.

PARAMETERS : pa_lv TYPE disvariant-variant.
*&---------------------------------------------------------------------*
*& Include          MZ_MENTORING_20250123_M_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.
  SET TITLEBAR 'TITLE_0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module MOVE_TO_RESULT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE move_to_result OUTPUT.
  kna1-kunnr = gs_cust-kunnr.
  kna1-land1 = gs_cust-land1.
  kna1-name1 = gs_cust-name1.
  kna1-ort01 = gs_cust-ort01.
  kna1-pstlz = gs_cust-pstlz.
  kna1-stras = gs_cust-stras.
  kna1-telf1 = gs_cust-telf1.
  kna1-adrnr = gs_cust-adrnr.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0150 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0150 OUTPUT.
  SET PF-STATUS 'STATUS_0150'.
  SET TITLEBAR 'TITLE_0150'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_CALL_TOP
*&---------------------------------------------------------------------*

DATA : ok_code TYPE sy-ucomm.

DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv_grid  TYPE REF TO cl_gui_alv_grid.

DATA : gt_flight TYPE TABLE OF spfli,
       gs_flight TYPE spfli.

DATA : gs_layout TYPE lvc_s_layo.
*&---------------------------------------------------------------------*
*& Include          ZD17_MENTORING_0203_TOP
*&---------------------------------------------------------------------*


TABLES : ztd17_salesorder.
TABLES: sscrfields.

*DATA : gv_mara  TYPE ztd17_salesorder.

DATA : gt_order TYPE TABLE OF ztd17_salesorder.

DATA : gv_switch TYPE i VALUE 0.

DATA : gv_ucomm TYPE sy-ucomm.

"screen
DATA : ok_code TYPE sy-ucomm.
DATA : go_container TYPE REF TO cl_gui_custom_container,      "custom container
       go_alv_grid  TYPE REF TO cl_gui_alv_grid.             "alv_grid

DATA : gs_variant TYPE disvariant,
       gv_save    TYPE c.

DATA : gs_layout TYPE lvc_s_layo.
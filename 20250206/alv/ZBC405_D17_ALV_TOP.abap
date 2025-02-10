*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_ALV_TOP
*&---------------------------------------------------------------------*
*ABAP
*DATA : gs_flight TYPE sflight,
*       gt_flight TYPE TABLE OF sflight.
TYPES : BEGIN OF ty_sflight.
          INCLUDE TYPE sflight.           "데이터
"INCLUDE STRUCTURE TYPE SFLIGHT
TYPES :   color  TYPE c LENGTH 4,         "row 컬러 값
          light,                          "신호등 값 공간
          it_col TYPE lvc_t_scol,         "cell coloring(필드 + 컬러)
          changes_possible TYPE icon-id,  "changes_possible(4)랑 동일 => icon-id가 char 4자리기 때문에.
        END OF ty_sflight.

DATA : gs_field_color TYPE LINE OF lvc_t_scol.

DATA : gs_flight TYPE ty_sflight,
       gt_flight TYPE TABLE OF ty_sflight.

DATA : gt_field_cat TYPE lvc_t_fcat,
       gs_field_cat TYPE lvc_s_fcat.


*SCREEN
DATA : ok_code TYPE sy-ucomm.
DATA  : go_container TYPE REF TO cl_gui_custom_container,      "custom container
        go_alv_grid  TYPE REF TO cl_gui_alv_grid.             "alv_grid



" layout variant
DATA : gs_variant TYPE disvariant,
       gv_save.

" layout
DATA : gs_layout TYPE lvc_s_layo.

" Sort
DATA : gt_sort TYPE lvc_t_sort,
       gs_sort TYPE lvc_s_sort.

" Toolbar excluding
DATA : gt_toolbar TYPE ui_functions.
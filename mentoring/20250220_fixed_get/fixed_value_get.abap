*&---------------------------------------------------------------------*
*& Report ZD17_MENTORING_0220_JOIN_F
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_mentoring_0220_join_f.

" 1. 타입 선언
TYPES : BEGIN OF ty_sbook.
          INCLUDE TYPE sbook.
TYPES :   ddtext TYPE val_text.
TYPES : END OF ty_sbook.

" 2. 변수 선언 - 내부 테이블 work area
DATA : gt_sbook TYPE TABLE OF ty_sbook,
       gs_sbook TYPE ty_sbook.

DATA : lt_dd07t TYPE TABLE OF dd07v,
       ls_dd07s TYPE dd07v.

DATA : go_alv TYPE REF TO cl_salv_table.


*START-OF-SELECTION.
START-OF-SELECTION.
  SELECT * FROM sbook
  INTO CORRESPONDING FIELDS OF TABLE gt_sbook.


  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname         = 'S_CANCEL'
      text            = 'X'
*     FILL_DD07L_TAB  = ' '
    TABLES
      values_tab      = lt_dd07t
*     VALUES_DD07L    =
    EXCEPTIONS
      no_values_found = 1
      OTHERS          = 2.

*  "조건에 맞춰서 넣어야 함
*  " canceled->gs_sbook-canceled의 값이 'X'로 들어가 있고, lt_dd07t-fixed의 값이 x
  LOOP AT gt_sbook INTO gs_sbook.

    IF gs_sbook-cancelled = 'X'.
      "테이블 제어 x -> structure !!!
      READ TABLE lt_dd07t INTO ls_dd07s WITH KEY domvalue_l = 'X'.

      gs_sbook-ddtext = ls_dd07s-ddtext.
    ELSE.
      READ TABLE lt_dd07t INTO ls_dd07s WITH KEY domvalue_l = ''.

      gs_sbook-ddtext = ls_dd07s-ddtext.
    ENDIF.

    MODIFY gt_sbook FROM gs_sbook.
  ENDLOOP.

*  LOOP AT gt_sbook INTO gs_sbook.
*
*  read table LT_DD07V
*  with key DOMVALUE_L = gs_sbook-CANCELLED
*  into LS_DD07V.
*
*  GS_SBOOK-desc = LS_DD07V-DDTEXT.
*
*  MODIFY gt_sbook from gs_sbook TRANSPORTING desc.
*  ENDLOOP.


  cl_salv_table=>factory(
*  EXPORTING
*    list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*    r_container    =                           " Abstract Container for GUI Controls
*    container_name =
  IMPORTING
    r_salv_table   =      go_alv                     " Basis Class Simple ALV Tables
    CHANGING
      t_table        =  gt_sbook
  ).
*CATCH cx_salv_msg. " ALV: General Error Class with Message

  go_alv->display( ).
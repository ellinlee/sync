*&---------------------------------------------------------------------*
*& Include          ZD17_MENTORING_0203_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form set_title
*&---------------------------------------------------------------------*
*& tab 이름 지정.
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_title .
  gv_txt = 'Details'.

  tab1 = 'Material Master'.
  tab2 = 'Business Partner'.
  tab3 = 'Sales Order'.

ENDFORM.

**&---------------------------------------------------------------------*
**& Form check_val
**&---------------------------------------------------------------------*
**& validation 검증
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
*FORM check_val .
*  IF pa_chk = 'X'and so_mat IS INITIAL.
*    MESSAGE TEXT-m01 TYPE 'E'.
*  ENDIF.
*ENDFORM.

*&---------------------------------------------------------------------*
*& Form set_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_screen .
  CASE sy-dynnr.
    WHEN 1100.
      LOOP AT SCREEN.
        CASE pa_chk.
          WHEN 'X'.
            IF screen-group1 = 'MAT'.
              screen-input = 1.
            ENDIF.
          WHEN OTHERS.
            IF screen-group1 = 'MAT'.
              screen-input = 0.
            ENDIF.
            MODIFY SCREEN.
        ENDCASE.
      ENDLOOP.

    WHEN 1200.
      LOOP AT SCREEN.
        IF screen-group1 = 'CUS'.
          screen-active = gv_switch.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.

      IF gv_switch = '1'.
        gv_txt = TEXT-b01.
      ELSE.
        gv_txt = TEXT-b02.
        REFRESH : so_date2, so_time2.
      ENDIF.
    WHEN OTHERS.

  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form user_command
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM user_command .
  CASE sscrfields-ucomm.

    WHEN 'BTN1'.

      CHECK sy-dynnr = 1200.

      IF gv_switch = '1'.
        gv_switch = '0'.

      ELSE.
        gv_switch = '1'.

      ENDIF.

    WHEN 'CHK1'.

      LOOP AT SCREEN.

        IF screen-group1 = 'MAT'.
          screen-input = 1.
        ENDIF.

        MODIFY SCREEN.

      ENDLOOP.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  CASE 'X'.
    WHEN pa_doc1.
      SELECT * FROM ztd17_salesorder
        INTO CORRESPONDING FIELDS OF TABLE gt_order
        WHERE matnr IN  so_mat
        AND  ernam IN so_pers
        AND mtart IN so_matt
        AND ersda IN so_date1
        AND created_at_time IN so_time1
        AND mc_name1 IN so_patn
        AND partner IN so_name
        AND location_1 IN so_ctry
        AND crdat IN so_date2
        AND crtim IN so_time2
        AND auart = 'TA'
        .
      .
      IF sy-subrc <> 0.
        MESSAGE TEXT-m02 TYPE 'E'.
        RETURN.
      ENDIF.

    WHEN pa_doc2.
      SELECT * FROM ztd17_salesorder
        INTO CORRESPONDING FIELDS OF TABLE gt_order
        WHERE matnr IN  so_mat
        AND  ernam IN so_pers
        AND mtart IN so_matt
        AND ersda IN so_date1
        AND created_at_time IN so_time1
        AND mc_name1 IN so_patn
        AND partner IN so_name
        AND location_1 IN so_ctry
        AND crdat IN so_date2
        AND crtim IN so_time2
        AND auart = 'RE'
      .
      IF sy-subrc <> 0.
        MESSAGE TEXT-m03 TYPE 'E'.
        RETURN.
      ENDIF.


    WHEN pa_doc3.
      SELECT * FROM ztd17_salesorder
        INTO CORRESPONDING FIELDS OF TABLE gt_order
        WHERE matnr IN so_mat
        AND  ernam IN so_pers
        AND mtart IN so_matt
        AND ersda IN so_date1
        AND created_at_time IN so_time1
        AND mc_name1 IN so_patn
        AND partner IN so_name
        AND location_1 IN so_ctry
        AND crdat IN so_date2
        AND crtim IN so_time2
        AND auart = 'ARBQ'.

      IF sy-subrc <> 0.
        MESSAGE TEXT-m04 TYPE 'E'.
      ENDIF.


  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form write_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM write_data .
*  LOOP AT gt_order INTO gv_order.
*    WRITE: / gv_order-matnr,         " Material Number (자재 번호)
*           gv_order-ernam,           " Created By (생성자 ID)
*           gv_order-mtart,           " Material Type (자재 유형)
*           gv_order-ersda,           " Created On (생성일자)
*           gv_order-created_at_time, " Created Time (생성 시간)
*           gv_order-name_org1,       " Organization Name (조직명)
*           gv_order-partner,         " Business Partner (비즈니스 파트너 번호)
*           gv_order-location_1,      " Country (국가 코드)
*           gv_order-crdat,           " Record Creation Date (레코드 생성일)
*           gv_order-crtim,           " Record Creation Time (레코드 생성 시간)
*           gv_order-vbeln,           " Sales Document Number (판매 문서 번호)
*           gv_order-auart.           " Sales Document Type (판매 문서 유형)
*  ENDLOOP.
*ENDFORM.

*&---------------------------------------------------------------------*
*& Form init_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_alv .
  CREATE OBJECT go_container
    EXPORTING
      container_name = 'MY_CONTROL_AREA'.
  IF sy-subrc <> 0.
    MESSAGE a010(bc405_408).
  ENDIF.

  CREATE OBJECT go_alv_grid
    EXPORTING
      i_parent = go_container.
  IF sy-subrc <> 0.
    MESSAGE a010(bc405_408).
  ENDIF.


  PERFORM set_layout.

  go_alv_grid->set_table_for_first_display(
    EXPORTING
*      i_buffer_active               =                  " Buffering Active
*      i_bypassing_buffer            =                  " Switch Off Buffer
*      i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition
      i_structure_name              =      'ZTD17_SALESORDER'   " Internal Output Table Structure Name
      is_variant                    =      gs_variant           " Layout
      i_save                        =      gv_save              " Save Layout
*      i_default                     = 'X'              " Default Display Variant
      is_layout                     =      gs_layout            " Layout
*      is_print                      =                  " Print Control
*      it_special_groups             =                  " Field Groups
*      it_toolbar_excluding          =                  " Excluded Toolbar Standard Functions
*      it_hyperlink                  =                  " Hyperlinks
*      it_alv_graphics               =                  " Table of Structure DTC_S_TC
*      it_except_qinfo               =                  " Table for Exception Quickinfo
*      ir_salv_adapter               =                  " Interface ALV Adapter
    CHANGING
      it_outtab                     =      gt_order            " Output Table
*      it_fieldcatalog               =                  " Field Catalog
*      it_sort                       =                  " Sort Criteria
*      it_filter                     =                  " Filter Criteria
*    EXCEPTIONS
*      invalid_parameter_combination = 1                " Wrong Parameter
*      program_error                 = 2                " Program Errors
*      too_many_lines                = 3                " Too many Rows in Ready for Input Grid
*      others                        = 4
  ).
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.



ENDFORM.

*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  gs_variant-report = sy-cprog.
  gv_save = 'X'.

  gs_layout-grid_title = TEXT-h01.
  gs_layout-sel_mode = 'A'.   "space, A, B, C, D

ENDFORM.

*&---------------------------------------------------------------------*
*& Form check_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM check_data .
*IF gt_order is INITIAL.
*  CASE 'X'.
*    WHEN pa_doc1.
*      MESSAGE TEXT-m02 TYPE 'E'.
*    WHEN pa_doc2.
*      MESSAGE TEXT-m03 TYPE 'E'.
*    WHEN OTHERS.
*      MESSAGE TEXT-m04 TYPE 'E'.
*  ENDCASE.
*
*ENDIF.
*ENDFORM.
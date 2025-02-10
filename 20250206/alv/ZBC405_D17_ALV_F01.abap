*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_ALV_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data1 .
    SELECT *
        FROM sflight
        INTO CORRESPONDING FIELDS OF TABLE gt_flight
        WHERE carrid IN so_carr
        AND connid IN so_conn.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form init_alv
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM init_alv .
    " 1. 컨테이너 객체 생성
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'.
    IF sy-subrc <> 0.
      MESSAGE a010(bc405_408).
    ENDIF.
  
    " 2. 그리드 객체 생성
    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container.
    IF sy-subrc <> 0.
      MESSAGE a010(bc405_408).
    ENDIF.
  
  *--------------------------------------------------------------------*
  * 메소드의 매개변수 채우는 곳!
  *--------------------------------------------------------------------*
    " layout variant
    PERFORM set_layout.
    PERFORM set_sort.
    PERFORM set_toolbar_excluding.
    PERFORM set_field_catalog.
  
    " 3. 그리드의 메소드를 통해 데이터 출력.
    "3-1. shortform
    go_alv_grid->set_table_for_first_display(
    EXPORTING
  *    i_buffer_active               =                  " Buffering Active
  *    i_bypassing_buffer            =                  " Switch Off Buffer
  *    i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition
      i_structure_name               = 'SFLIGHT'       " Internal Output Table Structure Name
      is_variant                     = gs_variant      " Layout
      i_save                         = gv_save         " Save Layout "U, A, X
      i_default                      = 'X'              " Default Display Variant - default로 적용된 것을 보여달라는 뜻
      is_layout                      =  gs_layout       " Layout
  *    is_print                      =                  " Print Control
  *    it_special_groups             =                  " Field Groups
      it_toolbar_excluding          =      gt_toolbar            " Excluded Toolbar Standard Functions
  *    it_hyperlink                  =                  " Hyperlinks
  *    it_alv_graphics               =                  " Table of Structure DTC_S_TC
  *    it_except_qinfo               =                  " Table for Exception Quickinfo
  *    ir_salv_adapter               =                  " Interface ALV Adapter
      CHANGING
        it_outtab                     =       gt_flight        " Output Table
      it_fieldcatalog               =       gt_field_cat     " Field Catalog
      it_sort                       =       gt_sort           " Sort Criteria
  *    it_filter                     =                  " Filter Criteria
  *  EXCEPTIONS
  *    invalid_parameter_combination = 1                " Wrong Parameter
  *    program_error                 = 2                " Program Errors
  *    too_many_lines                = 3                " Too many Rows in Ready for Input Grid
  *    others                        = 4
    ).
    IF sy-subrc <> 0.
      MESSAGE a010(bc405_408).
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
    gs_variant-variant = pa_lv.
    gv_save = 'A'.
  
    " layout
  *  gs_layout-zebra = 'X'.
  *  gs_layout-smalltitle = 'X'.
  *  gs_layout-cwidth_opt = 'X'.
  *  gs_layout-no_hgridln = 'X'.
    gs_layout-grid_title = TEXT-h01.
    gs_layout-sel_mode = 'A'.    "space, A, B, C, D
  *  gs_layout-no_toolbar = 'X'.   "분명한 목적이 있을 때만 활용한다. 없애지마
  
    gs_layout-excp_fname = 'LIGHT'.   " 출력하고자하는 인터널 테이블에서 신호등 값이 있는 핃드 이름.
    gs_layout-excp_led = 'X'.
  
  * cell row color
    gs_layout-info_fname = 'COLOR'.
    gs_layout-ctab_fname = 'IT_COL'.
  
  
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form set_sort
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM set_sort .
    " sort
    gs_sort-fieldname = 'SEATSMAX'. "정렬 기준
    gs_sort-up = 'X'.               "오름차순 (default)
    gs_sort-spos = 2.
  
  
    APPEND gs_sort TO gt_sort.
    CLEAR gs_sort.
  
    gs_sort-fieldname = 'SEATSOCC'.
    gs_sort-down = 'X'.
    gs_sort-spos = 1.
  
    APPEND gs_sort TO gt_sort.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form make_data
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM make_data .
  
    LOOP AT gt_flight INTO gs_flight.
  
      IF gs_flight-seatsocc = 0.
        gs_flight-light = '1'.
      ELSEIF gs_flight-seatsocc < 50.
        gs_flight-light = '2'.
      ELSE.
        gs_flight-light = '3'.
      ENDIF.
  
      IF gs_flight-fldate(6) = sy-datum(6).
        gs_flight-color = 'C' && col_negative && '01'.
      ENDIF.
  
      IF gs_flight-planetype = '747-400'.
        gs_field_color-fname = 'PLANETYPE'.
        gs_field_color-color-col = col_positive.
        gs_field_color-color-int = 1.
        gs_field_color-color-inv = 0.
        APPEND gs_field_color TO gs_flight-it_col.
        CLEAR gs_field_color.
      ENDIF.
  
      IF gs_flight-seatsocc >= 300.
        gs_field_color-fname = 'SEATSOCC'.
        gs_field_color-color-col = col_total.
        gs_field_color-color-int = 1.
        gs_field_color-color-inv = 0.
        APPEND gs_field_color TO gs_flight-it_col.
      ENDIF.
  
      IF gs_flight-fldate < sy-datum.
        gs_flight-changes_possible = '@5F@'.
      ELSE.
        gs_flight-changes_possible = '@01@'.
      ENDIF.
  
      MODIFY gt_flight FROM gs_flight TRANSPORTING light color it_col changes_possible.
  
    ENDLOOP.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form set_toolbar_excluding
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM set_toolbar_excluding .
  
    "1. info button 없애기
    APPEND '&INFO' TO gt_toolbar.
    " = APPEND cl_gui_alv_grid=>mc_fc_info to gt_toolbar
    " cl_gui_alv_grid=>mc_fc_info = '&INFO'
  
    "2. sort 없애기
    APPEND cl_gui_alv_grid=>mc_fc_sort TO gt_toolbar.
  
    "3. total
    APPEND cl_gui_alv_grid=>mc_mb_sum TO gt_toolbar.
  
    "4. Filter
    APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_toolbar.
  
    "5. 다 없애기
  *APPEND cl_gui_alv_grid=>mc_fc_excl_all to gt_toolbar.
  
  ENDFORM.
  
  
  *&---------------------------------------------------------------------*
  *& Form set_field_catalog
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM set_field_catalog .
    gs_field_cat-fieldname = 'SEATSOCC'.
    gs_field_cat-do_sum = 'X'.
  
    APPEND gs_field_cat TO gt_field_cat.
  
    CLEAR gs_field_cat.
  
    gs_field_cat-fieldname = 'PAYMENTSUM'.
    gs_field_cat-no_out = 'X'.
  
    APPEND gs_field_cat TO gt_field_cat.
    CLEAR gs_field_cat.
  *
    gs_field_cat-fieldname = 'LIGHT'.
    gs_field_cat-coltext = 'Utilization'(h02).
  
    APPEND gs_field_cat TO gt_field_cat.
    CLEAR gs_field_cat.
  
    gs_field_cat-fieldname = 'CHANGES_POSSIBLE'.
    gs_field_cat-col_pos = 5.
  *  gs_field_cat-icon = 'X'.          "예전에는 아이콘 값만 보여주게 되었기에 이 코드를 사용함. 또, 아이콘이 중앙 정렬됨.
    gs_field_cat-just = 'C'.
    gs_field_cat-coltext = 'Changes Possible'(h03).
    gs_field_cat-tooltip = 'Are Changes Possible?'(h04).
  
    APPEND gs_field_cat TO gt_field_cat.
    CLEAR gs_field_cat.
  
  ENDFORM.
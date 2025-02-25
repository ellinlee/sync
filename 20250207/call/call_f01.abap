*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_CALL_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form init_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_alv .

  "CONTAINER 객체 생성
  CREATE OBJECT go_container
    EXPORTING
*     parent         =                  " Parent container
      container_name = 'CONTROL_AREA'             " Name of the Screen CustCtrl Name to Link Container To
*     style          =                  " Windows Style Attributes Applied to this Container
*     lifetime       = lifetime_default " Lifetime
*     repid          =                  " Screen to Which this Container is Linked
*     dynnr          =                  " Report To Which this Container is Linked
*     no_autodef_progid_dynnr     =                  " Don't Autodefined Progid and Dynnr?
*    EXCEPTIONS
*     cntl_error     = 1                " CNTL_ERROR
*     cntl_system_error           = 2                " CNTL_SYSTEM_ERROR
*     create_error   = 3                " CREATE_ERROR
*     lifetime_error = 4                " LIFETIME_ERROR
*     lifetime_dynpro_dynpro_link = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
*     others         = 6
    .

  "ALV_GRID 객체 생성
  CREATE OBJECT go_alv_grid
    EXPORTING
*     i_shellstyle            = 0                " Control Style
*     i_lifetime              =                  " Lifetime
      i_parent = go_container               " Parent Container
*     i_appl_events           = space            " Register Events as Application Events
*     i_parentdbg             =                  " Internal, Do not Use
*     i_applogparent          =                  " Container for Application Log
*     i_graphicsparent        =                  " Container for Graphics
*     i_name   =                  " Name
*     i_fcat_complete         = space            " Boolean Variable (X=True, Space=False)
*     o_previous_sral_handler =
*    EXCEPTIONS
*     error_cntl_create       = 1                " Error when creating the control
*     error_cntl_init         = 2                " Error While Initializing Control
*     error_cntl_link         = 3                " Error While Linking Control
*     error_dp_create         = 4                " Error While Creating DataProvider Control
*     others   = 5
    .

  SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_double_click FOR go_alv_grid.

  PERFORM set_layout.



  go_alv_grid->set_table_for_first_display(
    EXPORTING
*      i_buffer_active               =                  " Buffering Active
*      i_bypassing_buffer            =                  " Switch Off Buffer
*      i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition
      i_structure_name              =  'SPFLI'                " Internal Output Table Structure Name
*      is_variant                    =                  " Layout
*      i_save                        =                  " Save Layout
*      i_default                     = 'X'              " Default Display Variant
      is_layout                     =   gs_layout            " Layout
*      is_print                      =                  " Print Control
*      it_special_groups             =                  " Field Groups
*      it_toolbar_excluding          =                  " Excluded Toolbar Standard Functions
*      it_hyperlink                  =                  " Hyperlinks
*      it_alv_graphics               =                  " Table of Structure DTC_S_TC
*      it_except_qinfo               =                  " Table for Exception Quickinfo
*      ir_salv_adapter               =                  " Interface ALV Adapter
    CHANGING
      it_outtab                     =  gt_flight              " Output Table
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
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_flight
    WHERE carrid IN so_carr
    AND connid IN so_conn.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form on_toolbar
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_OBJECT
*&---------------------------------------------------------------------*
FORM on_toolbar  USING po_object TYPE REF TO cl_alv_event_toolbar_set.

  DATA : ls_button TYPE stb_button.

  ls_button-function = 'MAINTAIN'.
  ls_button-butn_type = '0'.
  ls_button-quickinfo = 'Maintain connection'.
  ls_button-icon = icon_change.

  INSERT ls_button INTO TABLE po_object->mt_toolbar.
  CLEAR ls_button.

  ls_button-function = 'DISPLAY'.
  ls_button-butn_type = '0'.
  ls_button-quickinfo = 'Display the flight info'.
  ls_button-icon = icon_ws_plane.

  INSERT ls_button INTO TABLE po_object->mt_toolbar.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form on_user_commmand
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_UCOMM
*&---------------------------------------------------------------------*
FORM on_user_commmand  USING po_ucomm TYPE sy-ucomm.
  "함수용 변수
  DATA : lt_row_no TYPE lvc_t_roid,
         ls_row_no TYPE LINE OF lvc_t_roid.
  DATA : ls_flight TYPE spfli,
         lt_flight TYPE TABLE OF spfli.


*  DATA : ls_row_no1 TYPE lvc_s_roid.
*  DATA : ls_row_id TYPE   lvc_s_row.

  CASE po_ucomm.
    WHEN 'MAINTAIN'.

      go_alv_grid->get_selected_rows(
        IMPORTING
          et_row_no     = lt_row_no                  " Numeric IDs of Selected Rows
      ).
      IF lines( lt_row_no ) > 2.
        MESSAGE TEXT-m02 TYPE 'I'.
        EXIT.
      ELSEIF lines( lt_row_no ) = 0.
        MESSAGE TEXT-m01 TYPE'I'.
      ELSE.
        LOOP AT lt_row_no INTO ls_row_no.
          READ TABLE gt_flight INTO gs_flight INDEX ls_row_no-row_id.

          SET PARAMETER:
           ID 'CAR' FIELD gs_flight-carrid,
           ID 'CON' FIELD gs_flight-connid.

          CALL TRANSACTION 'SAPBC405CAL'.
          EXIT.
        ENDLOOP.
        CLEAR lt_row_no.
      ENDIF.


    WHEN 'DISPLAY'.
      go_alv_grid->get_selected_rows(
        IMPORTING
*            et_index_rows =                  " Indexes of Selected Rows
          et_row_no     = lt_row_no                 " Numeric IDs of Selected Rows
      ).

      LOOP AT lt_row_no INTO ls_row_no.
        READ TABLE gt_flight INTO gs_flight INDEX ls_row_no-row_id.
        CHECK sy-subrc = 0.
        ls_flight = gs_flight.
        APPEND ls_flight TO lt_flight.
      ENDLOOP.

      EXPORT mem_it_spfli FROM lt_flight TO MEMORY ID 'BC405'.
      SUBMIT bc405_call_flights AND RETURN.
  ENDCASE.
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
  gs_layout-sel_mode = 'A'.
ENDFORM.


*&---------------------------------------------------------------------*
*& Form on_double_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&---------------------------------------------------------------------*
FORM on_double_click  USING  pS_ROW_NO TYPE lvc_s_roid.

  READ TABLE gt_flight INTO gs_flight INDEX ps_row_no-row_id.

  SET PARAMETER:
    ID 'CAR' FIELD gs_flight-carrid,
    ID 'CON' FIELD gs_flight-connid.

  SUBMIT zbc405_d17_alv AND RETURN
    WITH so_carr EQ gs_flight-carrid
    WITH so_conn EQ gs_flight-connid.

ENDFORM.

*&---------------------------------------------------------------------*
*& Include          ZD17_EXAM5_C01
*&---------------------------------------------------------------------*

CLASS lcl_event_handler DEFINITION.
  PUBLIC SECTION.

    CLASS-DATA: gv_rowid TYPE i.

    CLASS-METHODS : on_double_click
      FOR EVENT double_click
      OF cl_gui_alv_grid
      IMPORTING es_row_no
                sender    .            "event parameter에는 안보이지만 기본적으로 존재함

    CLASS-METHODS : on_toolbar
      FOR EVENT toolbar
      OF cl_gui_alv_grid
      IMPORTING e_object.

    CLASS-METHODS : on_user_command
      FOR EVENT user_command
      OF cl_gui_alv_grid
      IMPORTING e_ucomm.


ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.
  METHOD on_double_click.
    PERFORM on_double_click USING es_row_no.
  ENDMETHOD.


  METHOD on_toolbar.
    PERFORM on_toolbar1 USING e_object.
  ENDMETHOD.


  METHOD on_user_command.
    PERFORM on_user_command USING e_ucomm.
  ENDMETHOD.

ENDCLASS.
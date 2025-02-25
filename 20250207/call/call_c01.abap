*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_CALL_C01
*&---------------------------------------------------------------------*
CLASS : lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS : on_toolbar
      FOR EVENT toolbar
      OF cl_gui_alv_grid
      IMPORTING e_object.

    CLASS-METHODS: on_user_command
      FOR EVENT user_command
      OF cl_gui_alv_grid
      IMPORTING e_ucomm.

    CLASS-METHODS : on_double_click
      FOR EVENT double_click
      OF cl_gui_alv_grid
      IMPORTING ES_ROW_NO.

ENDCLASS.


CLASS : lcl_handler IMPLEMENTATION.
  METHOD : on_toolbar.
    PERFORM on_toolbar USING e_object.
  ENDMETHOD.

  METHOD : on_double_click.
    PERFORM on_double_click USING ES_ROW_NO.
  ENDMETHOD.


  METHOD : on_user_command.
    PERFORM on_user_commmand USING e_ucomm.
  ENDMETHOD.




ENDCLASS.
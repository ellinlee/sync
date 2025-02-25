*----------------------------------------------------------------------*
***INCLUDE MBC414_CUST_TI01
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      IF sy-datar IS INITIAL AND
         gv_data_changed IS INITIAL.
*       no changes on screen 100
        LEAVE PROGRAM.
      ELSE.
        PERFORM ask_save CHANGING gv_result.
        CASE gv_result.
          WHEN '1'.
            ok_code = 'SAVE&EXIT'.
          WHEN '2'.
            LEAVE PROGRAM.
          WHEN 'A'.
            SET SCREEN '0100'.
        ENDCASE.
      ENDIF.
    WHEN 'CANCEL'.
      IF sy-datar IS INITIAL AND
         gv_data_changed IS INITIAL.
*       no changes on screen 100
        LEAVE TO SCREEN 0.
      ELSE.
        PERFORM ask_loss.
      ENDIF.
  ENDCASE.
ENDMODULE.                             " EXIT  INPUT


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'SAVE&EXIT'.
      PERFORM save CHANGING scustom.
      LEAVE PROGRAM.
    WHEN 'SAVE'.
      IF gv_data_changed IS INITIAL.
        SET SCREEN '0100'.
      ELSE.
        PERFORM save CHANGING scustom.
        SET SCREEN '0000'.
      ENDIF.
    WHEN 'BACK'.
      IF gv_data_changed IS INITIAL.
        SET SCREEN '0000'.
      ELSE.
        PERFORM ask_save CHANGING gv_result.
        CASE gv_result.
          WHEN '1'.
            PERFORM save CHANGING scustom.
            SET SCREEN '0000'.
          WHEN '2'.
            SET SCREEN '0000'.
          WHEN 'A'.
            SET SCREEN '0100'.
        ENDCASE.
      ENDIF.
  ENDCASE.
ENDMODULE.                             " USER_COMMAND_0100  INPUT


*&---------------------------------------------------------------------*
*&      Module  MARK_CHANGED  INPUT
*&---------------------------------------------------------------------*
MODULE mark_changed INPUT.

* set flag to mark changes were made on screen 100
  gv_data_changed = abap_true.

ENDMODULE.                             " MARK_CHANGED  INPUT
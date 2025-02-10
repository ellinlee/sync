*&---------------------------------------------------------------------*
*& Include          MZ_MENTORING_20250123_M_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_CUST  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_cust INPUT.
  SELECT SINGLE *
    FROM kna1
    INTO gs_cust
    WHERE kunnr = kna1-kunnr AND
          land1 = kna1-land1.

  IF sy-subrc <> 0.
    MESSAGE TEXT-001 TYPE 'i'.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
 CASE ok_code.
    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'DATE'.      "function code 적어주기.
      CALL SCREEN 150 STARTING AT 10 10 ENDING AT 60 25.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      CLEAR ok_code.
      SET PARAMETER ID :
      'CAR' FIELD sdyn_conn-carrid,
      'CON' FIELD sdyn_conn-connid,
      'DAY' FIELD sdyn_conn-fldate.
      LEAVE TO SCREEN 100.
  ENDCASE.
ENDMODULE.



*&---------------------------------------------------------------------*
*& Include          MZBC410_SOLUTION_DD17I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
      "UPDATE SFLIGHT FROM GS_FLIGHT.
    WHEN 'TIME'.
      CALL SCREEN 150
                  STARTING AT 10 10
                  ENDING AT 50 20.
  ENDCASE.

  CASE io_command.
    WHEN 'X'.
      LEAVE TO SCREEN 0.
    WHEN 'T'.
      CALL SCREEN 150
          STARTING AT 10 10
          ENDING AT 50 20.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_sflight INPUT.
  SELECT SINGLE *
    FROM sflight
    INTO gs_flight
    WHERE carrid = sdyn_conn-carrid
    AND connid = sdyn_conn-connid
    AND fldate = sdyn_conn-fldate.

  IF sy-subrc <> 0.
    MESSAGE e007(bc410).
    CLEAR gs_flight.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  GET_CURSOR  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_cursor INPUT.
  GET CURSOR FIELD gv_field.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  CHECK_PLANETYPE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_planetype INPUT.
  IF sdyn_conn-planetype IS INITIAL.
    MESSAGE e555(bc410) WITH 'Error'.
  ELSE.
    SELECT SINGLE seatsmax
      FROM saplane
      INTO sdyn_conn-seatsmax
      WHERE planetype = sdyn_conn-planetype.

    IF sdyn_conn-seatsmax < sdyn_conn-seatsocc.
      MESSAGE e109(bc410).
    ELSE.
      MOVE-CORRESPONDING sdyn_conn TO gs_flight.
    ENDIF.
  ENDIF.
ENDMODULE.
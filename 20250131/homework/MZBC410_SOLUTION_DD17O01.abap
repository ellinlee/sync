*&---------------------------------------------------------------------*
*& Include          MZBC410_SOLUTION_DD17O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.
  SET TITLEBAR 'TITLE_0100'.
    IF VIEW = 'X'.
    SET TITLEBAR 'TITLE_0100' WITH TEXT-001.
  ELSEIF maintain_flights = 'X'.
    SET TITLEBAR 'TITLE_0100' WITH TEXT-002.
  ELSE.
    SET TITLEBAR 'TITLE_0100' WITH TEXT-003.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SET_CURSOR OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_cursor OUTPUT.
  SET CURSOR FIELD gv_field.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module MOVE_TO_DYNP OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE move_to_dynp OUTPUT.
  sdyn_conn-price = gs_flight-price.
  sdyn_conn-currency = gs_flight-currency.
  sdyn_conn-planetype = gs_flight-planetype.
  sdyn_conn-seatsmax = gs_flight-seatsmax.
  sdyn_conn-seatsocc = gs_flight-seatsocc.
  sdyn_conn-paymentsum = gs_flight-paymentsum.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module CLEAR_OK_CODE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen OUTPUT.
  IF maintain_flights = 'X'.
    LOOP AT SCREEN.
      IF screen-name = 'SDYN_CONN-PLANETYPE'.
        screen-input = '1'.
      ENDIF.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module GET_SPFLI OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_spfli OUTPUT.
  ON CHANGE OF gs_flight-carrid
            OR gs_flight-connid.
    SELECT SINGLE *
      FROM spfli
      INTO CORRESPONDING FIELDS OF sdyn_conn
      WHERE carrid = gs_flight-carrid
      AND connid = gs_flight-connid.
  ENDON.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module GET_SPLANE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_splane OUTPUT.
  ON CHANGE OF gs_flight-planetype.
    SELECT SINGLE *
      FROM saplane
      INTO CORRESPONDING FIELDS OF saplane
      WHERE planetype = gs_flight-planetype.
  ENDON.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0150 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0150 OUTPUT.
 SET PF-STATUS 'STATUS_0150'.
 SET TITLEBAR 'TITLE_0150'.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module FILL_DYNNR OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE fill_dynnr OUTPUT.
  CASE 'X'.
    WHEN view.
      gv_dynnr = '0110'.
    WHEN maintain_flights.
      gv_dynnr = '0120'.
    WHEN maintain_bookings.
      gv_dynnr = '0130'.
  ENDCASE.
ENDMODULE.
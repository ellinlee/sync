PROCESS BEFORE OUTPUT.
  MODULE status_0100.
  MODULE set_cursor.
  MODULE move_to_dynp.
  MODULE clear_ok_code.
  MODULE modify_screen.
  MODULE fill_dynnr.
  CALL SUBSCREEN sub INCLUDING sy-cprog gv_dynnr.


PROCESS AFTER INPUT.
  MODULE exit AT EXIT-COMMAND.
  CALL SUBSCREEN sub.

  CHAIN.
    FIELD : sdyn_conn-carrid,
            sdyn_conn-connid,
            sdyn_conn-fldate.
    MODULE check_sflight ON CHAIN-REQUEST.
  ENDCHAIN.

  MODULE get_cursor.

  CHAIN.
    FIELD :sdyn_conn-seatsmax,
           sdyn_conn-planetype.
    MODULE
      check_planetype ON CHAIN-REQUEST.
  ENDCHAIN.

 MODULE USER_COMMAND_0100.
*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_SOL_S01
*&---------------------------------------------------------------------*

*- 101 : flight connection
SELECTION-SCREEN BEGIN OF SCREEN 101 AS SUBSCREEN.
  SELECT-OPTIONS : so_car FOR gs_flight-carrid,               "airline
                   so_con FOR gs_flight-connid.               "connection number

  SELECTION-SCREEN SKIP 2.
  SELECTION-SCREEN PUSHBUTTON /pos_low(20) gv_txt USER-COMMAND btn1.
  SELECTION-SCREEN SKIP 1.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
    SELECT-OPTIONS : so_dep FOR gs_flight-cityfrom MODIF ID det,      "screen group1
                     so_arr FOR gs_flight-cityto MODIF ID det.
  SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN END OF SCREEN 101.

*- 102 : flight
SELECTION-SCREEN BEGIN OF SCREEN 102 AS SUBSCREEN.
  SELECT-OPTIONS : so_date FOR gs_flight-fldate NO-EXTENSION.
SELECTION-SCREEN END OF SCREEN 102.


*- 103: display flights
SELECTION-SCREEN BEGIN OF SCREEN 103 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02.
  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
    PARAMETERS : pa_rad1 RADIOBUTTON GROUP rad1,
                 pa_rad2 RADIOBUTTON GROUP rad1,
                 pa_rad3 RADIOBUTTON GROUP rad1 DEFAULT 'X'.
  SELECTION-SCREEN end OF BLOCK b3.

  PARAMETERS : pa_ctry  LIKE gs_flight-countryto. "변수의 경우 Like
  "paramters : pa_ctry type dv_flights-countryto.
    SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF SCREEN 103.

*- tabstrip (101, 102, 103) : button(=tab) (+fcode, ucomm) + subscreen
SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_block FOR 15 LINES.
  SELECTION-SCREEN TAB (20) tab1 USER-COMMAND comm1 DEFAULT SCREEN 101.
  SELECTION-SCREEN TAB (10) tab2 USER-COMMAND comm2 DEFAULT SCREEN 102.
  SELECTION-SCREEN TAB (20) tab3 USER-COMMAND comm3 DEFAULT SCREEN 103.
SELECTION-SCREEN END OF BLOCK tab_block.
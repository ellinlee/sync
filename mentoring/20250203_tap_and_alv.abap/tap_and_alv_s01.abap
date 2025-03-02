*&---------------------------------------------------------------------*
*& Include          ZD17_MENTORING_0203_S01
*&---------------------------------------------------------------------*

*- 1100 : material master
SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.

    SELECTION-SCREEN SKIP.

    PARAMETERS : pa_chk AS CHECKBOX USER-COMMAND chk1.

    SELECTION-SCREEN SKIP.

    SELECT-OPTIONS : so_mat  FOR ztd17_salesorder-matnr NO-EXTENSION NO INTERVALS,
                so_pers FOR ztd17_salesorder-ernam MODIF ID mat NO-EXTENSION NO INTERVALS,
                so_matt FOR ztd17_salesorder-mtart MODIF ID mat NO-EXTENSION NO INTERVALS.

    SELECTION-SCREEN SKIP 1.

    SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02.

      SELECT-OPTIONS : so_date1 FOR ztd17_salesorder-ersda MODIF ID mat,
                       so_time1 FOR ztd17_salesorder-created_at_time MODIF ID mat.

    SELECTION-SCREEN END OF BLOCK b2.

  SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN END OF SCREEN 1100.

*- 1200: customer master
SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-t03.

    SELECT-OPTIONS :  so_patn FOR ztd17_salesorder-partner NO-EXTENSION NO INTERVALS,
                 so_name FOR ztd17_salesorder-mc_name1 NO-EXTENSION NO INTERVALS,
                 so_ctry FOR  ztd17_salesorder-cndsc NO-EXTENSION NO INTERVALS.


    SELECTION-SCREEN SKIP 1.

    SELECTION-SCREEN PUSHBUTTON /pos_low(20) gv_txt USER-COMMAND btn1.

    SELECTION-SCREEN ULINE.

    SELECTION-SCREEN SKIP 2.

    SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-t05.

      SELECT-OPTIONS : so_date2 FOR ztd17_salesorder-crdat MODIF ID cus,
                       so_time2 FOR ztd17_salesorder-crtim MODIF ID cus.

    SELECTION-SCREEN END OF BLOCK b4.

  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF SCREEN 1200.

*- 1300: sales order
SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-t04.

*    SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME.

    PARAMETERS : pa_doc1 RADIOBUTTON GROUP rad1 DEFAULT 'X',
                 pa_doc2 RADIOBUTTON GROUP rad1,
                 pa_doc3 RADIOBUTTON GROUP rad1.

*    SELECTION-SCREEN END OF BLOCK b6.

    SELECTION-SCREEN SKIP 1.

*    PARAMETERS : pa_sald LIKE gv_order-vbeln.

  SELECTION-SCREEN END OF BLOCK b5.

SELECTION-SCREEN END OF SCREEN 1300.


*- tabstrip
SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_block FOR 15 LINES.

  SELECTION-SCREEN TAB (20) tab1 USER-COMMAND matr DEFAULT SCREEN 1100.
  SELECTION-SCREEN TAB (20) tab2 USER-COMMAND cust DEFAULT SCREEN 1200.
  SELECTION-SCREEN TAB (20) tab3 USER-COMMAND ordr DEFAULT SCREEN 1300.

SELECTION-SCREEN END OF BLOCK tab_block.
*&---------------------------------------------------------------------*
*& Report ZD17_OUTER_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_outer_join.


TYPES : BEGIN OF gty_join,
          carrid   TYPE scarr-carrid,
          carrname TYPE scarr-carrname,
          connid   TYPE spfli-connid,
          cityfrom TYPE spfli-cityfrom,
          cityto   TYPE spfli-cityto,
        END OF gty_join.

DATA : gt_join TYPE TABLE OF gty_join.

DATA : go_alv_table TYPE REF TO cl_SALV_TABLE.

*--------------------------------------------------------------------*
*START-OF-SELECTION.
*--------------------------------------------------------------------*
START-OF-SELECTION.

  SELECT a~carrid, a~carrname,
         b~connid, b~cityfrom, b~cityto

    INTO TABLE @gt_join

    FROM scarr AS a
    LEFT OUTER JOIN spfli AS b
      ON a~carrid = b~carrid.


  cl_salv_table=>factory(
*      EXPORTING
*        list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*        r_container    =                           " Abstract Container for GUI Controls
*        container_name =
    IMPORTING
      r_salv_table   = go_alv_table                        " Basis Class Simple ALV Tables
    CHANGING
      t_table        = gt_join
  ).
*    CATCH cx_salv_msg. " ALV: General Error Class with Message


  go_alv_table->display( ).
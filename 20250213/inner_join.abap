*&---------------------------------------------------------------------*
*& Report ZBC405_D17_INNER_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_d17_inner_join.


TYPES : BEGIN OF gty_flight,
          carrid     TYPE spfli-carrid,
          connid     TYPE spfli-connid,
          fldate     TYPE sflight-fldate,
          cityfrom   TYPE spfli-cityfrom,
          cityto     TYPE spfli-cityto,
          fltime     TYPE spfli-fltime,
*          planetype  TYPE sflight-planetype,
          seatsmax   TYPE sflight-seatsmax,
          seatsocc   TYPE sflight-seatsocc,
          planetype  TYPE saplane-planetype,
          op_speed   TYPE saplane-op_speed,
          speed_unit TYPE saplane-speed_unit,
        END OF gty_flight.

DATA : gs_flight TYPE gty_flight.

DATA : gt_flight TYPE TABLE OF gty_flight.

DATA : go_alv_grid TYPE REF TO cl_salv_table.

SELECT-OPTIONS : so_carr FOR gs_flight-carrid,
                 so_conn FOR gs_flight-connid.

*--------------------------------------------------------------------*
*START-OF-SELECTION
*--------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT a~carrid a~connid
    b~fldate
    a~cityfrom a~cityto a~fltime
    b~seatsmax b~seatsocc
    b~planetype c~op_speed c~speed_unit
    FROM spfli AS a
    INNER JOIN sflight AS b
    ON a~carrid = b~carrid
    AND a~connid = b~connid
    INNER JOIN saplane AS c
    ON b~planetype = c~planetype
    INTO CORRESPONDING FIELDS OF TABLE gt_flight
    WHERE a~carrid IN so_carr
    AND a~connid IN so_conn.


  cl_salv_table=>factory(
*      EXPORTING
*        list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*        r_container    =                           " Abstract Container for GUI Controls
*        container_name =
    IMPORTING
      r_salv_table   =  go_alv_grid                      " Basis Class Simple ALV Tables
    CHANGING
      t_table        =  gt_flight
  ).
*    CATCH cx_salv_msg. " ALV: General Error Class with Message

  go_alv_grid->display( ).
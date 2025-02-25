*&---------------------------------------------------------------------*
*& Report ZBC405_D17_GROUP_BY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_d17_group_by.

TYPES : BEGIN OF gty_sflight,
          carrid      TYPE sflight-carrid,
          connid      TYPE sflight-connid,
          seatsmax    TYPE sflight-seatsmax,
          seatsocc    TYPE sflight-seatsocc,
          num_flights TYPE i,
        END OF gty_sflight.


DATA : gs_flight TYPE gty_sflight.
DATA : gt_flight TYPE TABLE OF gty_sflight.

DATA : go_alv_grid TYPE REF TO cl_salv_table.

SELECT-OPTIONS: so_carr FOR gs_flight-carrid.

SELECT carrid, connid,
       SUM( seatsmax ) AS seatsmax, SUM( seatsocc ) AS seatsocc,
       COUNT( * ) AS num_flights
  FROM sflight
  WHERE carrid IN @so_carr
  GROUP BY carrid, connid
  INTO CORRESPONDING FIELDS OF TABLE @gt_flight.


cl_salv_table=>factory(
*    EXPORTING
*      list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*      r_container    =                           " Abstract Container for GUI Controls
*      container_name =
  IMPORTING
    r_salv_table   =  go_alv_grid              " Basis Class Simple ALV Tables
  CHANGING
    t_table        =  gt_flight
).
*  CATCH cx_salv_msg. " ALV: General Error Class with Message


go_alv_grid->display( ).
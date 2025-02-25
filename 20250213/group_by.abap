*&---------------------------------------------------------------------*
*& Report ZBC405_D17_GROUP_BY2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_d17_group_by2.

TYPES : BEGIN OF gty_flight,
          carrid       TYPE sflight-carrid,
          seatsmax     TYPE sflight-seatsmax,
          seatsocc     TYPE sflight-seatsocc,
          seatsmax_avg TYPE sflight-seatsmax,
          seatsocc_avg TYPE sflight-seatsocc,
          num_connid   TYPE i,
          num_flights  TYPE i,
        END OF gty_flight.

DATA : gs_flight TYPE gty_flight,
       gt_flight TYPE TABLE OF gty_flight.

DATA : go_alv_grid TYPE REF TO cl_salv_table.


SELECT-OPTIONS : so_carr FOR gs_flight-carrid,
                 so_avgmx FOR gs_flight-num_connid,
                 so_avgoc FOR gs_flight-num_flights.

START-OF-SELECTION.

  SELECT carrid,
         seatsmax,
         seatsocc,
         AVG( seatsmax ) AS seatsmax_avg,
         AVG( seatsocc ) AS seatsocc_avg,
        COUNT( DISTINCT connid ) AS num_connid,
        COUNT( * ) AS num_flights
    FROM sflight
    WHERE carrid IN @so_carr
    GROUP BY carrid,
             seatsmax,
             seatsocc
    HAVING COUNT( DISTINCT connid ) IN @so_avgmx
    AND COUNT( * ) IN @so_avgoc
    ORDER BY seatsmax_avg DESCENDING, seatsocc_avg DESCENDING
    INTO CORRESPONDING FIELDS OF TABLE @gt_flight.

  cl_salv_table=>factory(
*  EXPORTING
*    list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*    r_container    =                           " Abstract Container for GUI Controls
*    container_name =
    IMPORTING
      r_salv_table   =   go_alv_grid                        " Basis Class Simple ALV Tables
    CHANGING
      t_table        =  gt_flight
  ).
*CATCH cx_salv_msg. " ALV: General Error Class with Message


  go_alv_grid->display( ).
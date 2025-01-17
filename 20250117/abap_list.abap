*&---------------------------------------------------------------------*
*& Report ZBC400_D17_REP_A
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_d17_rep_a.

* 1. 데이터 선언
TYPE-POOLS: icon, col.

DATA : gs_flight TYPE bc400_s_flight,
       gt_flight TYPE TABLE OF bc400_s_flight.

CONSTANTS : gc_red    TYPE i VALUE 97,
            gc_yellow TYPE i VALUE 60.

PARAMETERS : pa_car TYPE sflight-carrid.

SELECT-OPTIONS : so_con FOR gs_flight-connid.

* 2. 데이터 불러오기
START-OF-SELECTION.

TRY.
    CALL METHOD cl_bc400_flightmodel=>get_flights_range
      EXPORTING
        iv_carrid  = pa_car
        it_connid  = so_con[]
      IMPORTING
        et_flights = gt_flight.
  CATCH cx_bc400_no_data.
    WRITE : / 'no data'.
  CATCH cx_bc400_no_auth.
    WRITE : / 'no authorization'.
ENDTRY.

* 3. 데이터 출력
LOOP AT gt_flight INTO gs_flight.
  IF gs_flight-percentage >= gc_red.
    WRITE : / icon_red_light AS ICON.
  ELSEIF gs_flight-percentage > gc_yellow.
    WRITE : / icon_yellow_light AS ICON.
  ELSE.
    WRITE : / icon_green_light AS ICON.
  ENDIF.

  WRITE : gs_flight-carrid COLOR COL_KEY,
          gs_flight-connid COLOR COL_KEY,
          ' ',
          gs_flight-fldate COLOR COL_KEY,
          gs_flight-seatsmax,
          gs_flight-seatsocc,
          '      ',
          gs_flight-percentage.
ENDLOOP.
*&---------------------------------------------------------------------*
*& Report ZBC400_D17_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_d17_loop.


*  1. global data object 선언
DATA : gt_connections TYPE bc400_t_connections,   "table type
       gs_connection  TYPE bc400_s_connection.      "Structure

* 2. 데이터 추출
START-OF-SELECTION.


  TRY.
      CALL METHOD cl_bc400_flightmodel=>get_connections
        EXPORTING
          iv_carrid      = space
        IMPORTING
          et_connections = gt_connections.
    CATCH cx_bc400_no_data.
      WRITE : / 'no data.'.
    CATCH cx_bc400_no_auth.
      WRITE : / 'no authorization'.
  ENDTRY.

** 정렬
  SORT gt_connections BY deptime ASCENDING.

* 3. 데이터 출력

  LOOP AT gt_connections INTO gs_connection.
    WRITE : / gs_connection-airpfrom,
              gs_connection-airpto,
              gs_connection-arrtime,
              gs_connection-carrid,
              gs_connection-cityfrom,
              gs_connection-cityto,
              gs_connection-connid,
              gs_connection-deptime,
              gs_connection-fltime.
  ENDLOOP.
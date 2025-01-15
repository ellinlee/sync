*&---------------------------------------------------------------------*
*& Report ZBC_D17_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_d17_structure.

* parameter 변수 선언
PARAMETERS : pa_car  TYPE bc400_s_flight-carrid,
             pa_con  TYPE bc400_s_flight-connid,
             pa_date TYPE bc400_s_flight-fldate.
*             pa_con  TYPE s_conn_id,
*             pa_date TYPE s_date.

* strucuture 선언 - (global type 2 + local type 1 -> global variable 1)
DATA : gs_carrier TYPE bc400_s_carrier,
       gs_flight  TYPE bc400_s_flight.

* 내부 structure 선언
TYPES : BEGIN OF gty_carrierflight,
          carrid     TYPE bc400_s_carrier-carrid,
          connid     TYPE bc400_s_flight-connid,
          carrname   TYPE bc400_s_carrier-carrname,
          currcode   TYPE bc400_s_carrier-currcode,
          url        TYPE bc400_s_carrier-url,
          fldate     TYPE bc400_s_flight-fldate,
          seatsmax   TYPE bc400_s_flight-seatsmax,
          seatsocc   TYPE bc400_s_flight-seatsocc,
          percentage TYPE bc400_s_flight-percentage,
        END OF gty_carrierflight.

* 내부 structure 활용 data 선언
DATA: gs_carrierflight TYPE gty_carrierflight.

* method 호출
TRY.
    CALL METHOD cl_bc400_flightmodel=>get_carrier
      EXPORTING
        iv_carrid  = pa_car
      IMPORTING
        es_carrier = gs_carrier.
  CATCH cx_bc400_no_data.
    WRITE : / 'no data!'.
    EXIT.
  CATCH cx_bc400_no_auth.
    WRITE : / 'no authorization!'.
    EXIT.
ENDTRY.


TRY.
    CALL METHOD cl_bc400_flightmodel=>get_flight
      EXPORTING
        iv_carrid = pa_car
        iv_connid = pa_con
        iv_fldate = pa_date
      IMPORTING
        es_flight = gs_flight.
  CATCH cx_bc400_no_data.
    WRITE : / 'no data!'.
    EXIT.
  CATCH cx_bc400_no_auth.
    WRITE : / 'no authorization!'.
    EXIT.
ENDTRY.

* 같은 내용이기에 아래와 같이 작성해도 똑같이 작동
*TRY.
*    CALL METHOD cl_bc400_flightmodel=>get_carrier
*      EXPORTING
*        iv_carrid  = pa_car
*      IMPORTING
*        es_carrier = gs_carrier.
*    CALL METHOD cl_bc400_flightmodel=>get_flight
*      EXPORTING
*        iv_carrid = pa_car
*        iv_connid = pa_con
*        iv_fldate = pa_date
*      IMPORTING
*        es_flight = gs_flight.
*  CATCH cx_bc400_no_data.
*    WRITE : / 'no data!'.
*    EXIT.
*  CATCH cx_bc400_no_auth.
*    WRITE : / 'no authorization!'.
*    EXIT.
*ENDTRY.


MOVE-CORRESPONDING gs_carrier TO gs_carrierflight.
MOVE-CORRESPONDING gs_flight TO gs_carrierflight.

IF gs_carrierflight IS NOT INITIAL.
  WRITE : / gs_carrierflight-carrid,
          / gs_carrierflight-connid,
          / gs_carrierflight-carrname,
          / gs_carrierflight-currcode,
          / gs_carrierflight-fldate,
          / gs_carrierflight-percentage,
          / gs_carrierflight-seatsmax LEFT-JUSTIFIED,
          / gs_carrierflight-seatsocc LEFT-JUSTIFIED,
          / gs_carrierflight-url.
ELSE.
  WRITE : / 'there is no data'.
ENDIF.
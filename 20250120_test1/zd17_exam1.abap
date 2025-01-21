*&---------------------------------------------------------------------*
*& Report ZD17_EXAM1
*&---------------------------------------------------------------------*
*&  좌석 등급별 좌석 계산 프로그램.
*&---------------------------------------------------------------------*
REPORT zd17_exam1.

*-1. data type 정의 및 data 선언
**-1.1. table 타입 활용해 sflight와 이름이 같은 structure 선언 (구조만 갖고 옴).
TABLES : sflight.

**-1-2. 결과에 대한 structure 선언.
TYPES: BEGIN OF ts_sflight,
         carrid       TYPE s_carr_id,
         connid       TYPE s_conn_id,
         fldate       TYPE s_date,
         seatsmax     TYPE s_seatsmax,
         SEATSMAX_b   TYPE s_smax_b,
         seatsmax_f   TYPE s_smax_f,
         tot_seatsmax TYPE s_seatsmax,
         seatsocc     TYPE s_seatsocc,
         seatsocc_b   TYPE s_socc_b,
         seatsocc_f   TYPE s_smax_f,
         tot_seatsocc TYPE s_seatsocc,
       END OF ts_sflight.

**-1-3. internal table 및 work area 선언.
DATA : gv_flight TYPE TABLE OF ts_sflight,
       gs_flight TYPE ts_sflight.

*-2. 입력 변수들 위치한 Box 선언.
** b1 box안에 여러 입력 조건 선언.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.          "조회조건.
  PARAMETERS : pa_carr TYPE sflight-carrid OBLIGATORY DEFAULT 'AA'.    "항공사ID.
  SELECT-OPTIONS : so_conn FOR sflight-connid,                         "연결번호.
  so_date FOR sflight-fldate.                                          "항공일정.
SELECTION-SCREEN END OF BLOCK b1.


*-3. START-OF-SELECTION
** 로직 시작 (데이터 가져오기).
START-OF-SELECTION.

**-3-1. 데이터 추출.
***3-1-1. 입력 화면에서 입력한 조건에 따라 데이터 추출.
  SELECT * FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gv_flight
    WHERE carrid = pa_carr
    AND connid IN so_conn
    AND fldate IN so_date.

***-3-1-2. 맞는 데이터가 없다면 메세지 출력.
  IF sy-subrc <> 0.
    MESSAGE '조건에 맞는 데이터가 없습니다.' TYPE 'S'.
  ENDIF.

**-3-2. 데이터 가공 및 처리.
  LOOP AT gv_flight INTO gs_flight.

***-3-2-1. 함수 호출해 interanl table의 값들 차례차례 계산.
    PERFORM calculate_sum
      USING gs_flight-seatsmax
            gs_flight-seatsmax_b
            gs_flight-seatsmax_f
            gs_flight-seatsocc
            gs_flight-seatsocc_b
            gs_flight-seatsocc_f

      CHANGING gs_flight-tot_seatsmax
               gs_flight-tot_seatsocc.

***-3-2-2. 결과 값 internal table에 반영.
    MODIFY gv_flight FROM gs_flight INDEX sy-tabix.

***-3-3. 출력
      WRITE : / gs_flight-carrid,
              gs_flight-connid,
              gs_flight-fldate,
              gs_flight-seatsmax,
              gs_flight-seatsmax_b,
              gs_flight-seatsmax_f,
              gs_flight-tot_seatsmax COLOR COL_GROUP,
              gs_flight-seatsocc,
              gs_flight-seatsocc_b,
              gs_flight-seatsocc_f,
              gs_flight-tot_seatsocc COLOR COL_GROUP.

  ENDLOOP.



*&---------------------------------------------------------------------*
*& Form calculate_sum
*&---------------------------------------------------------------------*
*& 좌석등급별 최대좌석수 합계와 좌석 등급별 예약 좌석수 합계 구하는 subroutine.
*&---------------------------------------------------------------------*
*& -->  uv_seatsmax, uv_seatsmax_b, uv_seatsmax_f, uv_seatsmax_b,
*&      uv_seatsocc, uv_seatsocc_b, uv_seatsocc_f  갖고 와 사용할 값.
*& <--  cv_tot_seatsmax, cv_tot_seatsocc 결과를 변경해 전달할 값.
*&---------------------------------------------------------------------*
FORM calculate_sum
  USING uv_seatsmax TYPE s_seatsmax
        uv_seatsmax_b TYPE s_smax_b
        uv_seatsmax_f TYPE s_smax_f
        uv_seatocc TYPE s_seatsocc
        uv_seatsocc_b TYPE s_socc_b
        uv_seatsocc_f TYPE s_socc_f

  CHANGING cv_tot_seatsmax TYPE s_seatsmax
           cv_tot_seatsocc TYPE s_seatsocc.

  cv_tot_seatsmax = uv_seatsmax + uv_seatsmax_b + uv_seatsmax_f.
  cv_tot_seatsocc = uv_seatocc + uv_seatsocc_b + uv_seatsocc_f.

ENDFORM.
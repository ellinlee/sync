*&---------------------------------------------------------------------*
*& Include          MZD17_EXAM4_I01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       100번 screen exit, cancel 클릭에 대한 모듈.
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
      "exit 버튼 클릭 시 프로그램 종료.
    WHEN 'EXIT'.
      LEAVE PROGRAM.

      "cancel 버튼 클릭 시 화면 상 데이터 모두 지우고, 100번 스크린으로 다시 갱신.
    WHEN 'CANCEL'.
      CLEAR gs_customer.
      CLEAR gs_booking.
      CLEAR gs_movie.
      CLEAR gs_theater.
      CLEAR gs_showtime.
      LEAVE TO SCREEN 100.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       100번 스크린 back 버튼 클릭에 대한 모듈.
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      SET SCREEN 0.
    WHEN 'CUSTOMER_INFO' OR 'BOOK'.
      tab1-activetab = ok_code.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  GET_DATA  INPUT
*&---------------------------------------------------------------------*
*       회원 정보 입력한 조건에 따라 데이터 얻어오는 모듈.
*----------------------------------------------------------------------*
MODULE get_data INPUT.
  SELECT SINGLE *
    FROM ztd17_customer
    INTO CORRESPONDING FIELDS OF gs_customer
    WHERE cust_id = ztd17_customer-cust_id.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0120  INPUT
*&---------------------------------------------------------------------*
*       subscreen 120번 버튼 클릭에 대한 모듈.
*----------------------------------------------------------------------*
MODULE user_command_0120 INPUT.
  CASE ok_code.
    WHEN 'BUT1'.

      "채번
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr = '01'
          object      = 'ZD17_BNO'
*         QUANTITY    = '1'
*         SUBOBJECT   = ' '
*         TOYEAR      = '0000'
*         IGNORE_BUFFER                 = ' '
        IMPORTING
          number      = gs_booking-book_id
*         QUANTITY    =
*         RETURNCODE  =
*       EXCEPTIONS
*         INTERVAL_NOT_FOUND            = 1
*         NUMBER_RANGE_NOT_INTERN       = 2
*         OBJECT_NOT_FOUND              = 3
*         QUANTITY_IS_0                 = 4
*         QUANTITY_IS_NOT_1             = 5
*         INTERVAL_OVERFLOW             = 6
*         BUFFER_OVERFLOW               = 7
*         OTHERS      = 8
        .

      "채번 안되었을 시 오류 메시지 띄우기.
      IF sy-subrc <> 0.
        MESSAGE '오류입니다.'(m03) TYPE 'E'.
      ENDIF.

      "예약 정보 데이터 채우기.
      gs_booking-cust_id = ztd17_customer-cust_id.
      gs_booking-showtime_id = ztd17_showtime-showtime_id.
      gs_booking-book_date = sy-datum.
      gs_booking-changed_by = sy-uname.
      gs_booking-changed_on = sy-datum.
      gs_booking-changed_time = sy-uzeit.
      gs_booking-seat_no = 'H03'.

      "ztd10_booking(예약 정보) 테이블에 위에서 생성한 데이터 저장.
      INSERT INTO ztd17_booking VALUES gs_booking.

      "데이터 저장 로직에 따른 메시지 처리.
      ""저장 오류 시 에러 메시지 띄우기.
      IF sy-subrc <> 0.
        MESSAGE '예매 생성에 실패했습니다.'(m04) TYPE 'E'.

        " 저장 성공 시 성공 메시지 띄우기.
      ELSE.
        MESSAGE '예매가 성공적으로 완료되었습니다.'(m05) TYPE 'S'.
      ENDIF.

  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  GET_DATA_0120  OUTPUT
*&---------------------------------------------------------------------*
*       영화 예매 입력한 조건에 따른 데이터 얻어오는 모듈.
*----------------------------------------------------------------------*
MODULE get_data_0120 INPUT.
  "영화 정보 가져오기 (ztd17_movie)
  SELECT SINGLE *
    FROM ztd17_movie
    INTO CORRESPONDING FIELDS OF gs_movie
    WHERE movie_id = ztd17_movie-movie_id. "movie-id가 입력이 안되는디 흠

  "극장 정보 가져오기 (ztd17_theater)
  SELECT SINGLE *
    FROM ztd17_theater
    INTO CORRESPONDING FIELDS OF gs_theater
    WHERE theater_id = ztd17_theater-theater_id.

  "영화 ID 혹은 극장 ID 미입력시 에러 메세지 띄우기
  IF ztd17_theater-theater_id IS INITIAL OR ztd17_movie-movie_id IS INITIAL.
    MESSAGE '영화 및 극장 정보 필수 입력입니다.'(m01) TYPE 'E'.
  ENDIF.

  "입력한 영화 ID, 극장 ID를 조건으로 하여 상영 시간 정보 가져오기 (ztd17_showtime)
  SELECT SINGLE *
    FROM ztd17_showtime
    INTO CORRESPONDING FIELDS OF gs_showtime
    WHERE movie_id = ztd17_movie-movie_id
    AND theater_id = ztd17_theater-theater_id.

  "데이터 미 존재 시 에러 메세지 띄우기.
  IF sy-subrc <> 0.
    MESSAGE '해당하는 극장에 상영시간이 없습니다.'(m02) TYPE 'S' DISPLAY LIKE 'E'.
    CLEAR gs_movie.
    CLEAR gs_theater.
  ENDIF.

ENDMODULE.
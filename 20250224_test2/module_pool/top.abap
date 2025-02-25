*&---------------------------------------------------------------------*
*& Include          MZD17_EXAM4_TOP
*&---------------------------------------------------------------------*

*스크린에서 참고하여 생성한 테이블 선언.
TABLES : ztd17_customer, ztd17_movie, ztd17_theater, ztd17_showtime.

*입력(버튼 클릭, 화면 전환 등)에 대한 변수 선언.
DATA : ok_code TYPE sy-ucomm.

*고객 정보 입력 조건에 맞는 데이터를 담을 work area 선언
DATA : gs_customer TYPE ztd17_customer.

*영화 예매(영화 정보) 입력에 따른 데이터를 담을 work area 선언.
DATA : gs_movie TYPE ztd17_movie.

*영화 예매(극장 정보) 입력에 따른 데이터를 담을 work area 선언.
DATA : gs_theater TYPE ztd17_theater.

*영화 예매(상영 시간 정보) 입력에 따른 데이터를 담을 work area 선언.
DATA : gs_showtime TYPE ztd17_showtime.

*영화 예매 정보 입력에 따른 데이터를 담을 work area 선언.
DATA : gs_booking TYPE ztd17_booking.

*screen num 변수.
DATA : gv_dynnr TYPE sy-dynnr.

*tab 선언.
CONTROLS : tab1 TYPE TABSTRIP.
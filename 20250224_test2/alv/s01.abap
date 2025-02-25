*&---------------------------------------------------------------------*
*& Include          ZD17_EXAM5_S01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01."조회조건 box.

  PARAMETERS : pa_book RADIOBUTTON GROUP rad1 USER-COMMAND disp DEFAULT 'X', "예매번호로 조회.
               pa_cust RADIOBUTTON GROUP rad1.                               "회원번호로 조회.
SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02. "선택정보 box

  "예매 번호 - 라디오 버튼에 따라 display 여부 결정하기 위해 modif id 설정
  SELECT-OPTIONS : so_book FOR ztd17_booking-book_id MODIF ID bid.

*  "고객 ID - 라디오 버튼에 따라 display 여부 결정하기 위해 modif id 설정
  SELECT-OPTIONS : so_cust FOR ztd17_booking-cust_id MODIF ID cid.


SELECTION-SCREEN END OF BLOCK b2.
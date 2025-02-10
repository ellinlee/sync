*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_ALV_E01
*&---------------------------------------------------------------------*\

*--------------------------------------------------------------------*
*INITIALIZATION
*--------------------------------------------------------------------*
INITIALIZATION.

*--------------------------------------------------------------------*
*At SELECTION-SCREEN
*버튼 눌렀을 때 어떤 PAI가 실행되는지.
*push button의 fcode
*--------------------------------------------------------------------*
*AT SELECTION-SCREEN. "PAI


*--------------------------------------------------------------------*
*At SELECTION-SCREEN on BLOCK b2.
*--------------------------------------------------------------------*
*AT SELECTION-SCREEN ON BLOCK b2.



*--------------------------------------------------------------------*
*AT SELECTION-SCREEN OUTPUT.
*전환된 토글값을 조건으로 숨길 대상의 active 속성 변경 후 버튼의 제목 변경
*--------------------------------------------------------------------*
*AT SELECTION-SCREEN OUTPUT.


*--------------------------------------------------------------------*
*START-OF-SELECTION.
*-1. 데이터 조회.
*-2. 데이터 출력.
*--------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM get_data1.   "데이터 조회. (DB 추출, itab 가공...)
  perform make_data.

  CALL SCREEN 100.    "출력을 위한 스크린 호출.
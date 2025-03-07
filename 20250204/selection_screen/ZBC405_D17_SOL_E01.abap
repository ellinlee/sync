*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_SOL_E01
*&---------------------------------------------------------------------*

*--------------------------------------------------------------------*
*INITIALIZATION
*--------------------------------------------------------------------*

INITIALIZATION.

  PERFORM init_value.     "입력값 초기화.
  PERFORM set_title.      "제목 초기화.

*--------------------------------------------------------------------*
*At SELECTION-SCREEN
*버튼 눌렀을 때 어떤 PAI가 실행되는지.
*push button의 fcode
*--------------------------------------------------------------------*
AT SELECTION-SCREEN. "PAI
  PERFORM change_toggle.

*--------------------------------------------------------------------*
*At SELECTION-SCREEN on BLOCK b2.
*block 안에 있는 모든 요소 확인
*-1. all - 국제선, 국내선 모두,
*-2. national - country key 있어야 함.(input check)- error message
*--------------------------------------------------------------------*
AT SELECTION-SCREEN ON BLOCK b2.
  PERFORM check_b2.


*--------------------------------------------------------------------*
*AT SELECTION-SCREEN OUTPUT.
*전환된 토글값을 조건으로 숨길 대상의 active 속성 변경 후 버튼의 제목 변경
*--------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.
  PERFORM change_button.



*--------------------------------------------------------------------*
*START-OF-SELECTION.
*-1. 데이터 조회.
*-2. 데이터 출력.
*--------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM get_data.   "데이터 조회. (DB 추출, itab 가공...)
  PERFORM write_data. "데이터 출력.
*&---------------------------------------------------------------------*
*& Report ZBC400_D17_HELLO
*&---------------------------------------------------------------------*
*& 프로그램명 : ZBC400_D17_HELLO
*& 프로그램 설명: 처음으로 만들어 봄~
*&---------------------------------------------------------------------*
REPORT zbc400_d17_hello.

* selection screen 요소
PARAMETERS : pa_name TYPE string. "매개변수 (화면에서 입력받아서 내부 로직으로 전달

* data 변수
DATA : gv_name TYPE string. "문자열 타입의 내부 변수가 선언

* 매개 변수를 내부 변수에 전달
MOVE pa_name TO gv_name.

* 출력
WRITE : / gv_name.
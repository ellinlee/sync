*&---------------------------------------------------------------------*
*& Report ZBC400_D17_HELLO
*&---------------------------------------------------------------------*
*& 프로그램명 : ZBC400_D17_HELLO
*& 프로그램 설명: 처음으로 만들어 봄~
*&---------------------------------------------------------------------*
REPORT zbc400_d17_hello.

* selection screen 요소
PARAMETERS : pa_name TYPE string. "매개변수 (화면에서 입력받아서 내부 로직으로 전달


WRITE : 'HELLO WORLD'.
WRITE : pa_name.

NEW-LINE.
* 1st way to make a new line
WRITE : 'HELLO WORLD1'.
NEW-LINE.  "new line 가능
WRITE : pa_name.

* 2nd way to make a new line
WRITE : / 'HELLO WORLD2', / pa_name.

*WRITE : 'hello world'. "문자열 안 소문자 대문자 구분됨
*WRITE : / 'hello1', /'hello2',/'hello3','hello4'. "슬래시는 줄바꿈
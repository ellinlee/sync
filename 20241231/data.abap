*&---------------------------------------------------------------------*
*& Report ZBC400_D17_HELLO
*&---------------------------------------------------------------------*
*& 프로그램명 : ZBC400_D17_HELLO
*& 프로그램 설명: 처음으로 만들어 봄~
*&---------------------------------------------------------------------*
REPORT zbc400_d17_hello.
"1st way
DATA : gv_name.
"2nd way
DATA : gv_name TYPE c.
"3rd way
DATA : gv_name TYPE c LENGTH 1. 

PARAMETERS : pa_name TYPE string. "매개변수 (화면에서 입력받아서 내부 로직으로 전달
PARAMETERS : pa_date TYPE d. "date 
PARAMETERS : pd_time TYPE t. "time
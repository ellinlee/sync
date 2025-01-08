*&---------------------------------------------------------------------*
*& Report ZD17_EX17
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_ex17.

* DATA DECLARATION
TYPES : tv_char10     TYPE c LENGTH 10,            "10자리 char의 데이터 타입 생성
        tv_age        TYPE i,                      "integer의 데이터 타입 생성
        tv_percentage TYPE p LENGTH 3 DECIMALS 2.  "정수 3자리, 소수 2자리 packaed number의 데이터 타입 생성

* PARAMETER DECLARATION
PARAMETERS : pa_dept TYPE tv_char10,      "부서명 입력 변수 선언/parameter 변수는 8자리까지 !
             pa_name TYPE tv_char10.      "이름 입력 변수 선언

* ELEMENTARY DATA OBJECT DECLARATION
DATA : gv_dept TYPE tv_char10,
       gv_name TYPE tv_char10,
       gv_age  TYPE tv_age,
       gv_date TYPE d.                    "gv_date type sy-datum으로 해도 ok

*DATA : lv_string TYPE string.

* DATA ALLOCATION & PRINT
gv_dept = pa_dept.
gv_name = pa_name.
gv_date = sy-datum.
gv_age = 20.

*lv_string = gv_age.
*CONDENSE lv_string.

WRITE : / '부서명 :', gv_dept.
WRITE : / '이름 : ', gv_name.
WRITE : / '날짜 : ', gv_date.
WRITE : / '나이 : ', gv_age.
*WRITE : / '나이 : ', lv_string.
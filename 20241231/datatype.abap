*&---------------------------------------------------------------------*
*& Report ZD17_MEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_memo.

* - LOCAL DATA TYPES (ABAP PROGRAM 에서만 존재함)

*타입을 정의할 뿐 값이 저장되거나 명령에 활용 x
TYPES : tv_c_type TYPE c LENGTH 8. "c type의 8자리
*WRITE tv_c_type -> 오류!

TYPES : tv_n_type TYPE n LENGTH 5. "n은 숫자로 이루어진 string

TYPES : tv_p_type TYPE p LENGTH 3 DECIMALS 2. "정수 부분 3자리 소수 부분 2자리 -> ---.--


*- data object
DATA : gv_name TYPE tv_c_type.  "local data type을 통해 선언된 data object
DATA : gv_name2 LIKE gv_name. "FROM data object
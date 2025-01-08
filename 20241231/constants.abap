*&---------------------------------------------------------------------*
*& Report ZD17_MEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_memo.

CONSTANTS : gv_myconst1 TYPE tv_n_type VALUE IS INITIAL. "값이 할당되지않은 초기값 상수
CONSTANTS : gv_myconst2 TYPE tv_n_type VALUE 12345."숫자
CONSTANTS : gv_myconst3 TYPE tv_n_type VALUE '12345'."숫자
CONSTANTS : gv_myconst4 TYPE tv_n_type VALUE 'abcde'.

WRITE : gv_myconst1, gv_myconst2, gv_myconst3, gv_myconst4.
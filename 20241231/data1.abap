*&---------------------------------------------------------------------*
*& Report ZD17_MEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_memo.
TYPES tv_percentage TYPE p LENGTH 3 DECIMALS 2.


DATA : gv_percentage TYPE tv_percentage,
       gv_number1    TYPE i VALUE 17,
       gv_number2    LIKE gv_number1,
       gv_city       TYPE c LENGTH 15,
       gv_carrid     TYPE s_carr_id,
       gv_connid     TYPE s_conn_id.

WRITE : / 'gv_percentage', gv_percentage,
        / 'gv_number1: ', gv_number1,
        / 'gv_number2: ', gv_number2,
        / 'gv_city: ', gv_city,
        / 'gv_carrid : ', gv_carrid,
        / 'gv_connid : ', gv_connid.
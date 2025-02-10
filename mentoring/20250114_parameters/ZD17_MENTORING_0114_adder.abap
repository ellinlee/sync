*&---------------------------------------------------------------------*
*& Report ZD17_MENTORING_0114
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_mentoring_0114.

DATA : gv_int1   TYPE i,
       gv_int2   TYPE i,
       gv_result TYPE i.

PARAMETERS : pa_int1 TYPE i,
             pa_int2 TYPE i.


gv_int1 = pa_int1.
gv_int2 = pa_int2.


PERFORM calculate_rectangle_area
  USING gv_int1
        gv_int2
  CHANGING gv_result.


*&---------------------------------------------------------------------*
*& Form CALCULATE_RECTANGLE_AREA
*&---------------------------------------------------------------------*
*& 직사각형 넓이 구하기
*&---------------------------------------------------------------------*
*&  가로 세로--> GV_INT1,GV_INT2
*&  결과값 --> GV_RESULT
*&---------------------------------------------------------------------*
FORM calculate_rectangle_area
   USING    pv_int1 LIKE gv_int1
            pv_int2 LIKE gv_int2
   CHANGING pv_result LIKE gv_result.


  DATA : lv_string type string.

  IF pv_int1 = 0 OR pv_int2 = 0.
    MESSAGE TEXT-t01 TYPE 'I'.        "WRONG INPUT! 출력
  ELSE.
    pv_result = pv_int1 * pv_int2.
    lv_string = pv_result.
    CONDENSE lv_string.
    WRITE : / '직사각형의 넓이는' , lv_string.
  ENDIF.

ENDFORM.
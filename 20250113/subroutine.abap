*&---------------------------------------------------------------------*
*& Report ZBC400_D17_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_d17_compute MESSAGE-ID zd17.

* PARAMETERS DECLARATION
PARAMETERS : pa_int1 TYPE i,
             pa_op   TYPE c LENGTH 1,
             pa_int2 TYPE i.


* DATA DECLARATION
DATA : gv_result TYPE p LENGTH 16 DECIMALS 2.


* operator case
CASE pa_op.
  WHEN '+'.
    gv_result = pa_int1 + pa_int2.
    PERFORM print_result
       USING gv_result.

  WHEN '-'.
    gv_result = pa_int1 - pa_int2.
    PERFORM print_result
       USING gv_result.

  WHEN '*'.
    gv_result =  pa_int1 * pa_int2.
    PERFORM print_result
      USING gv_result.

  WHEN '/'.
    "case for pa_int2=0 to print the error message.
    IF pa_int2 = 0.
*      WRITE : TEXT-t01.
      MESSAGE TEXT-t01 TYPE 'S'.
      EXIT.
    ELSE.
      gv_result = pa_int1 / pa_int2.
      PERFORM print_result
          USING gv_result.
    ENDIF.

  WHEN '%'.
    PERFORM calc_percentage
    USING pa_int1
          pa_int2
    CHANGING gv_result.

  WHEN OTHERS .
    WRITE : 'wrong input !'(m01).
    MESSAGE s003(zd17).
    EXIT.

ENDCASE.

* clear if needed.
CLEAR : gv_result.


*&---------------------------------------------------------------------*
*& Form calc_percentage
*&---------------------------------------------------------------------*
*& 백분율 계산
*&---------------------------------------------------------------------*
*& -->  pv_int1, pv_int2 actual parameter
*& <--  cv_result        format paramteter
*&---------------------------------------------------------------------*
FORM calc_percentage
  USING VALUE(pv_int1) TYPE i
        VALUE(pv_int2) TYPE i

  CHANGING VALUE(cv_result) TYPE p.

  IF pv_int2 = 0.
    MESSAGE TEXT-t02 TYPE 'I'.        "백분율 계산 오류! 출력
    EXIT.
  ELSE.
    cv_result = pv_int1 * 100 / pv_int2 .
    PERFORM print_result
      USING cv_result.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form print_result
*&---------------------------------------------------------------------*
*& 결과 출력
*&---------------------------------------------------------------------*
*& -->  cv_result actual parameter
*&---------------------------------------------------------------------*
FORM print_result
 USING VALUE(cv_result) TYPE p.

*DATA DECLARATION FOR THE PRINTING WITHOUT THE SPACE
  DATA : lv_string TYPE string.

  lv_string = cv_result.
  CONDENSE lv_string.                         " 공백 제거를 위해 condense 함수 사용

  CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'      " 음수의 경우 부호를 앞으로 가져오기 위해서 해당 함수 호출
    CHANGING
      value = lv_string.

  WRITE : 'The result is '(m02), lv_string.

ENDFORM.
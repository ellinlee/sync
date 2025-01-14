*&---------------------------------------------------------------------*
*& Report ZBC400_D17_COMPUTE_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_d17_compute_class.

* PARAMETERS DECLARATION
PARAMETERS : pa_int1 TYPE i,
             pa_op   TYPE c LENGTH 1,
             pa_int2 TYPE i.

* DATA DECLARATION
DATA : gv_result TYPE p LENGTH 16 DECIMALS 2.

* function call 을 위한 변수 선언
DATA : gv_base   TYPE bc400_compute_base,
       gv_power  TYPE bc400_compute_power,
       gv_return TYPE bc400_compute_result.

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
*    PERFORM calc_percentage
*    USING pa_int1
*          pa_int2
*    CHANGING gv_result.

*    CALL FUNCTION 'ZBC400_D17_COMP_PERCENTAGE'
*      EXPORTING
*        iv_act           = pa_int1
*        iv_max           = pa_int2
*      IMPORTING
*        ev_percentage    = gv_result
*      EXCEPTIONS
*        division_by_zero = 1
*        OTHERS           = 2.
*    IF sy-subrc <> 0.
** Implement suitable error handling here
*      CASE sy-subrc.
*        WHEN 1.
*          MESSAGE TEXT-t02 TYPE 'I'.
*          EXIT.
*        WHEN 2.
*          MESSAGE TEXT-t04 TYPE 'I'.
*      ENDCASE.
*    ELSE.
*      PERFORM print_result
*        USING gv_result.
*    ENDIF.

    CALL METHOD zcl_d17_compute=>get_percentage
      EXPORTING
        iv_act        = pa_int1
        iv_max        = pa_int2
      IMPORTING
        ev_percentage = gv_result.
    PERFORM print_result
 USING gv_result.


  WHEN 'P'.
    gv_base = pa_int1.
    gv_power = pa_int2.

    TRY.
        CALL METHOD cl_bc400_compute=>get_power
          EXPORTING
            iv_base   = gv_base
            iv_power  = gv_power
          IMPORTING
            ev_result = gv_return.
      CATCH cx_bc400_power_too_high.
        MESSAGE TEXT-t05 TYPE 'I'.
        EXIT.
      CATCH cx_bc400_result_too_high.
        MESSAGE TEXT-t03 TYPE 'I'.
        EXIT.
    ENDTRY.
    gv_result = gv_return.
    PERFORM print_result
      USING gv_result.
    
*    CALL FUNCTION 'BC400_MOS_POWER'
*      EXPORTING
*        iv_base               = gv_base
*        iv_power              = gv_power
*      IMPORTING
*        ev_result             = gv_return
*      EXCEPTIONS
*        power_value_too_high  = 1
*        result_value_too_high = 2
*        OTHERS                = 3.
*    IF sy-subrc <> 0.
* Implement suitable error handling here
*      CASE sy-subrc.
*        WHEN 1.
*          MESSAGE TEXT-t05 TYPE 'I'.
*        WHEN 2.
*          MESSAGE TEXT-t03 TYPE 'I'.
*        WHEN 3.
*          MESSAGE TEXT-t04 TYPE 'I'.
*      ENDCASE.
*    ELSE.
*      gv_result = gv_return.
*      PERFORM print_result
*        USING gv_result.
*    ENDIF.

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
*FORM calc_percentage
*  USING VALUE(pv_int1) TYPE i
*        VALUE(pv_int2) TYPE i
*
*  CHANGING VALUE(cv_result) TYPE p.
*
*  IF pv_int2 = 0.
*    MESSAGE TEXT-t02 TYPE 'I'.        "백분율 계산 오류! 출력
*    EXIT.
*  ELSE.
*    cv_result = pv_int1 * 100 / pv_int2 .
*    PERFORM print_result
*      USING cv_result.
*  ENDIF.
*ENDFORM.


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
  CONDENSE lv_string.

  CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'      " 음수의 경우 부호를 앞으로 가져오기 위해서 해당 함수 호출
    CHANGING
      value = lv_string.

  WRITE : 'The result is '(m02), lv_string LEFT-JUSTIFIED.

ENDFORM.
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

*DATA DECLARATION FOR THE PRINTING WITHOUT THE SPACE
DATA : lv_string TYPE string.

* operator case
CASE pa_op.
  WHEN '+'.
    gv_result = pa_int1 + pa_int2.
  WHEN '-'.
    gv_result = pa_int1 - pa_int2.
  WHEN '*'.
    gv_result =  pa_int1 * pa_int2.
  WHEN '/'.
    "case for pa_int2=0 to print the error message.
    IF pa_int2 = 0.
*      WRITE : TEXT-t01.
      MESSAGE TEXT-t01 TYPE 'S'.
      EXIT.
    ELSE.
      gv_result = pa_int1 / pa_int2.
    ENDIF.
  WHEN OTHERS .
    WRITE : 'wrong input !'(m01).
    MESSAGE s003(zd17).
    EXIT.
ENDCASE.

lv_string = gv_result.
CONDENSE lv_string.
WRITE : 'The result is '(m02), lv_string.
MESSAGE i002(zd17) WITH gv_result.


* clear if needed.
CLEAR : gv_result.
*&---------------------------------------------------------------------*
*& Report ZD17_GUGUDAN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_gugudan.

* Define the parameter variable
PARAMETERS : pa_int1 TYPE n LENGTH 3.         " use n for the case when user input 0 - c를 쓰게 된다면 문자 입력 exception 존재하기에

* Define the variable
DATA : gv_result TYPE n LENGTH 3.            " variable for multiplication result

* conditional statement
IF pa_int1 IS INITIAL.                    " if the user doesn't enter the value
  MESSAGE i005(ZD17).
ELSEIF pa_int1 NOT BETWEEN 2 AND 9.       " if the input value is not 2~9
  MESSAGE s004(ZD17) WITH '2' '9'.
ELSE.                                     " if the user input right value
  DO 9 TIMES.                             " Loop 9 times to calculate the multiplication from 1 to 9
    gv_result = pa_int1 * sy-index.       " multiply and assign it to the result
    WRITE : pa_int1 no-ZERO, ' * ', (1) sy-index, ' = ', gv_result no-ZERO.
    NEW-LINE.                             " add new line
  ENDDO.
ENDIF.

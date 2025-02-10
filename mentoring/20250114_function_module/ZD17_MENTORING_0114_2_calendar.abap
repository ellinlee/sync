*&---------------------------------------------------------------------*
*& Report ZD17_MENTORING_0114_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_mentoring_0114_2.

DATA : gv_date TYPE scdatum,
       gv_week TYPE kweek.

gv_date = sy-datum.

CALL FUNCTION 'DATE_GET_WEEK'
  EXPORTING
    date         = gv_date
  IMPORTING
    week         = gv_week
  EXCEPTIONS
    date_invalid = 1
    OTHERS       = 2.

IF sy-subrc <> 0.
* Implement suitable error handling here
  CASE sy-subrc .
    WHEN 1.
      WRITE : / 'date is invalid.'.
    WHEN 2.
      WRITE : / 'unkown error'.
  ENDCASE.
ELSE.
  WRITE: / 'date : ', gv_date.
  WRITE:  / 'week: ', gv_week.
ENDIF.
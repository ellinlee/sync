*----------------------------------------------------------------------*
***INCLUDE MBC414_CUST_TF01
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  NUMBER_GET_NEXT
*&---------------------------------------------------------------------*
*      <--cv_id  text
*----------------------------------------------------------------------*
FORM number_get_next CHANGING cv_id TYPE s_customer.

  DATA lv_rc TYPE nrreturn.

* get next free number in the number range '01'
* of number object'SBUSPID'
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '01'
      object      = 'SBUSPID'
    IMPORTING
      number      = cv_id
      returncode  = lv_rc
    EXCEPTIONS
      OTHERS      = 1.

  CASE sy-subrc.
    WHEN 0.
      CASE lv_rc.
        WHEN 1.
*         number of remaining numbers critical
          MESSAGE s070.
        WHEN 2.
*         last number
          MESSAGE s071.
        WHEN 3.
*         no free number left over
          MESSAGE a072.
      ENDCASE.
    WHEN 1.
*     internal error
      MESSAGE a073 WITH sy-subrc.
  ENDCASE.

ENDFORM.                               " NUMBER_GET_NEXT


*&---------------------------------------------------------------------*
*&      Form  ASK_SAVE
*&---------------------------------------------------------------------*
*      <--CV_FCODE  text
*----------------------------------------------------------------------*
FORM ask_save CHANGING cv_result TYPE gty_flag.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar      = TEXT-003
      text_question = TEXT-001
    IMPORTING
      answer        = cv_result.

ENDFORM.                               " ASK_SAVE


*&---------------------------------------------------------------------*
*&      Form  ASK_LOSS
*&---------------------------------------------------------------------*
FORM ask_loss.

  DATA lv_result TYPE c.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = TEXT-003
      text_question         = TEXT-004
      display_cancel_button = space
    IMPORTING
      answer                = lv_result.
  CASE lv_result.
    WHEN '1'.
      LEAVE TO SCREEN '0000'.
    WHEN '2'.
      CLEAR ok_code.
      LEAVE TO SCREEN '0100'.
  ENDCASE.

ENDFORM.                               " ASK_LOSS


*&---------------------------------------------------------------------*
*&      Form  SAVE
*&---------------------------------------------------------------------*
*      <--CS_SCUSTOM  text
*----------------------------------------------------------------------*
FORM save CHANGING cs_scustom TYPE scustom.

* get new number for SCUSTOM-ID from number range object BC_SCUSTOM
  PERFORM number_get_next CHANGING cs_scustom-id.

* ToDo: save new customer
  PERFORM save_customer USING cs_scustom.

ENDFORM.                               " SAVE

*&---------------------------------------------------------------------*
*& Form save_customer
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> CS_SCUSTOM
*&---------------------------------------------------------------------*
FORM save_customer  USING ps_scustom TYPE scustom.
  INSERT INTO zcustom_d00 VALUES ps_scustom .

  IF sy-subrc <> 0.
    MESSAGE a048(bc414).
  ELSE.
    MESSAGE s015(bc414) WITH ps_scustom-id.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Report S4D430D_DYNAMIC_ACCESS_TO_TEXT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_dynamic_access_to_text.



DATA gv_label TYPE string.


* Selection Screen

PARAMETERS pa_cds TYPE ddstrucobjname DEFAULT 'S4D430_ANNOTATIONS'.
PARAMETERS pa_elem TYPE ddfieldname_l DEFAULT 'CARRID'.
PARAMETERS pa_lang TYPE sy-langu DEFAULT 'DE'.


START-OF-SELECTION.

  gv_label =  cl_dd_ddl_annotation_service=>get_label_4_element(
        EXPORTING
          entityname  = 'S4D430_ANNOTATIONS'
          elementname = 'CARRID'
          language    = 'D'
      ).

  WRITE gv_label.
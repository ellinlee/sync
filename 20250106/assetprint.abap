*&---------------------------------------------------------------------*
*& Report ZBC430_D17_DATA_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc430_d17_data_elements.

* Define the data
DATA : lv_output TYPE zassets_d17,      " variable for the calculated assets
       lv_name TYPE string.             " variable for full name

* Define the parameter from global data type
PARAMETERS : pa_lname TYPE zlastname_d17,
             pa_fname TYPE zfirstname_d17,
             pa_activ TYPE zassets_d17,
             pa_liabs TYPE zliabilities_d17.

START-OF-SELECTION.                           " event 중 하나

* allocate name data
lv_name = |{ pa_lname } { pa_fname }|.        " to eliminate the space

* calculate the asset data
lv_output = pa_activ - pa_liabs.

* print the data
WRITE : '사용자 : ' , lv_name.
NEW-LINE.
WRITE :  '자산: ' , pa_activ,
        / '부채: ' , pa_liabs,
        / '순자산: ' , lv_output.
*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_CALL_E01
*&---------------------------------------------------------------------*

*--------------------------------------------------------------------*
*LOAD-OF-PROGRAM
*--------------------------------------------------------------------*
*GET PARAMETER ID 'CAR'.


*--------------------------------------------------------------------*
*INITIALIZATION
*--------------------------------------------------------------------*
INITIALIZATION.

*--------------------------------------------------------------------*
*AT SELECTION-SCREEN OUTPUT
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
*START-OF-SELECTION
*--------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM get_data.

  CALL SCREEN 100.
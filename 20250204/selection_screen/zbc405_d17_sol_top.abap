*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_SOL_TOP
*&---------------------------------------------------------------------*
* pushbuttone 및 user command 활용 : ok_code
TABLES: sscrfields.

* work area
DATA : gs_flight TYPE dv_flights,
       gv_switch TYPE i VALUE 1,
       gt_flight TYPE TABLE OF dv_flights.
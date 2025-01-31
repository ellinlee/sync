*&---------------------------------------------------------------------*
*& Include MZBC410_SOLUTION_DD17TOP                 - Module Pool      SAPMZBC410_SOLUTION_DD17
*&---------------------------------------------------------------------*
PROGRAM sapmzbc410_solution_dd17.

TABLES : sdyn_conn, saplane.

DATA : gs_flight         TYPE sflight,
       gv_field          TYPE fieldname,
       ok_code           TYPE sy-ucomm,
       io_command        TYPE c,
       view              VALUE 'X',
       maintain_flights,
       maintain_bookings,
       gv_dynnr          TYPE sy-dynnr.
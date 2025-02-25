*&---------------------------------------------------------------------*
*& Include MBC414_CUST_TTOP
*&---------------------------------------------------------------------*

PROGRAM sapmbc414_cust_t MESSAGE-ID bc414.

TYPES gty_flag TYPE c LENGTH 1.

DATA gv_result       TYPE gty_flag.
DATA gv_data_changed TYPE gty_flag.
DATA ok_code         TYPE syucomm.

TABLES: scustom.
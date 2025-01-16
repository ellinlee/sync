FUNCTION z_bc400_d17_flightlist_01.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(IV_CONNID) TYPE  S_CONN_ID
*"  EXPORTING
*"     REFERENCE(ET_FLIGHTS) TYPE  BC400_T_FLIGHTS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

  DATA : ls_flight TYPE LINE OF bc400_t_flights.

  SELECT carrid connid fldate seatsocc seatsmax
    FROM sflight
    INTO CORRESPONDING FIELDS OF ls_flight
    WHERE carrid = iv_carrid AND connid = iv_connid.
    ls_flight-percentage = ls_flight-seatsocc / ls_flight-seatsmax.
    APPEND ls_flight TO et_flights.
  ENDSELECT.
  IF sy-subrc <> 0.
    RAISE no_data.
  ENDIF.

ENDFUNCTION.
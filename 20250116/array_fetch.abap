FUNCTION z_bc400_d17_flightlist_02.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(IV_CONNID) TYPE  S_CONN_ID
*"  EXPORTING
*"     REFERENCE(EV_FLIGHTS) TYPE  BC400_T_FLIGHTS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

  DATA : ls_flight TYPE LINE OF bc400_t_flights.

  SELECT carrid connid fldate seatsmax seatsocc
         FROM sflight
         INTO CORRESPONDING FIELDS OF TABLE ev_flights
         WHERE carrid = iv_carrid AND
               connid = iv_connid.

  IF sy-subrc <> 0.
    RAISE no_data.
  ENDIF.



  LOOP AT ev_flights INTO ls_flight.
    ls_flight-percentage = ls_flight-seatsocc / ls_flight-seatsmax.
    MODIFY ev_flights FROM ls_flight INDEX sy-tabix TRANSPORTING percentage.
  ENDLOOP.

  SORT ev_flights BY percentage DESCENDING.




ENDFUNCTION.
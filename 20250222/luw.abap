*&---------------------------------------------------------------------*
*& Report ZD17_LUW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZD17_LUW.

*UPDATE sbook SET smoker = 'X'
*           WHERE carrid = 'AA'
*             AND connid = '0017'
*             AND bookid = '00000010'.
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*ELSE.
*  ROLLBACK WORK.
*ENDIF.

*CALL FUNCTION 'Z_UPDATE_FLIGHT'
*  IN UPDATE TASK
*  EXPORTING
*    flight_id = 'LH123'
*    new_price = '500'.
*
*COMMIT WORK.  " 이 시점에서 UPDATE TASK 실행됨.
*
*
*CALL FUNCTION 'Z_SEND_DATA'
*  IN BACKGROUND TASK
*  DESTINATION 'SAP_SYSTEM_A'
*  EXPORTING
*    param1 = value1
*    param2 = value2.
*
*COMMIT WORK.
*
*PERFORM update_customer ON COMMIT.
*
**&---------------------------------------------------------------------*
**& UPDATE_CUSTOMER
**&---------------------------------------------------------------------*
*FORM update_customer.
*  UPDATE zcustomer
*    SET status = 'ACTIVE'
*    WHERE customer_id = 'C1001'.
*ENDFORM.
*
*COMMIT WORK.  " 이 시점에서 update_customer 실행됨.
*
*
*
*CALL FUNCTION 'ENQUEUE_EZCUSTOMER'
*  EXPORTING
*    customer_id = 'C1001'.
*
*UPDATE zcustomer
*  SET status = 'ACTIVE'
*  WHERE customer_id = 'C1001'.
*
*CALL FUNCTION 'DEQUEUE_EZCUSTOMER'
*  EXPORTING
*    customer_id = 'C1001'.
*
*
*CALL FUNCTION 'Z_MASS_UPDATE'
*  IN BACKGROUND TASK
*  EXPORTING
*    company_code = '1000'.
*
*COMMIT WORK.
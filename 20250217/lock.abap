*&---------------------------------------------------------------------*
*& Report ZD17_LOCK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZD17_LOCK.
CALL FUNCTION 'ENQUEUE_EZ_SBOOK_D17'.

UPDATE sbook SET smoker = ''
           WHERE carrid = 'AA'
             AND connid = '0017'
             AND bookid = '00000010'.

CALL FUNCTION 'DEQUEUE_EZ_SBOOK_D17'.
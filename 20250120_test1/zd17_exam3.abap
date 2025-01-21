*&---------------------------------------------------------------------*
*& Report ZD17_EXAM3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_exam3.

DATA : gt_sbook TYPE bc400_t_bookings,
       gs_sbook TYPE LINE OF bc400_t_bookings.

*-1. 입력 변수들 위치한 Box 선언.
** b1 box안에 여러 입력 조건 선언.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.          "조회조건.
  PARAMETERS : pa_carr TYPE sbook-carrid OBLIGATORY,              "Airline.
               pa_conn TYPE sbook-connid OBLIGATORY,              "Connection Number
               pa_date TYPE sbook-fldate.                         "Flight Date.
SELECTION-SCREEN END OF BLOCK b1.

*-2. 입력 화면
AT SELECTION-SCREEN.
**-2.1 날짜 입력 안했을 시 에러 메세지 출력.
  IF pa_date IS INITIAL.
    MESSAGE e006(zd17).
  ENDIF.

*-3. 입력 변수에 따른 데이터를 얻어오기 위해 함수 호출.
START-OF-SELECTION.
  TRY.
      CALL METHOD cl_bc400_flightmodel=>get_bookings
        EXPORTING
          iv_carrid   = pa_carr
          iv_connid   = pa_conn
          iv_fldate   = pa_date
        IMPORTING
          et_bookings = gt_sbook.
    CATCH cx_bc400_no_data.
      MESSAGE i007(zd17).
    CATCH cx_bc400_no_auth.
      MESSAGE i008(zd17).
  ENDTRY.


*-4. 데이터 가공 및 처리.
** 출력.
  LOOP AT gt_sbook INTO gs_sbook.
    IF gs_sbook-cancelled = 'X'.        "취소 아이콘 출력
      WRITE : / icon_cancel AS ICON.
    ELSE.
      WRITE : / '   '.
    ENDIF.

    WRITE: gs_sbook-carrid COLOR COL_KEY,
           '    ',
           gs_sbook-connid COLOR COL_KEY,
           gs_sbook-fldate COLOR COL_KEY,
           gs_sbook-bookid,
           gs_sbook-customid,
           '  ',
           gs_sbook-custtype,
           '     ',
           gs_sbook-smoker,
           '    ',
           gs_sbook-counter,
           '  ',
           gs_sbook-agencynum,
           '   ',
           gs_sbook-cancelled.
  ENDLOOP.
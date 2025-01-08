*&---------------------------------------------------------------------*
*& Report ZBC430_D17_ITAB_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc430_d17_itab_sorted.

* -1. data 선언
DATA : gt_sflight TYPE zit_sflight_d17,    " internal table
       gs_sflight TYPE sflight.            " work area 선언

START-OF-SELECTION.

* -2. db data를 work area로 copy
** -2.1 WA 활용하여 select 반복문 활용한 사례 - 한 줄 씩!
  SELECT *
    FROM sflight             " 실제 data가 있는 DB table
    INTO gs_sflight
    WHERE carrid ='JL'.      "select 절 안에서는 테이블 이름 명시 필요 x

* -3. work area 데이터 출력 - 하나의 row를 선택하고 바로 출력하는 형식 - 계속 반복
    WRITE : / 'Airline code : ' , gs_sflight-carrid,
            'Flight connection number : ', gs_sflight-connid,
            'Flight date : ' , gs_sflight-fldate,
          'Airfare : ' , gs_sflight-price ,
         'Currency : ' , gs_sflight-currency,
         'Airclaft type : ' , gs_sflight-planetype.

  ENDSELECT.

** -2.2 internal table을 활용 - array fetch
  ULINE.
  WRITE : / 'print out from the itab.'.

  SELECT * FROM sflight           " DB 테이블에서 데이터 선택
    INTO TABLE gt_sflight         " INTERNAL TABLE에 전달
    WHERE carrid = 'JL'.

" itab은 출력을 위해서는 work area가 필요
  LOOP AT gt_sflight INTO gs_sflight.
    WRITE : / 'Airline code : ' , gs_sflight-carrid,
       'Flight connection number : ', gs_sflight-connid,
       'Flight date : ' , gs_sflight-fldate,
      'Airfare : ' , gs_sflight-price ,
       'Currency : ' , gs_sflight-currency,
      'Airclaft type : ' , gs_sflight-planetype.
  ENDLOOP.
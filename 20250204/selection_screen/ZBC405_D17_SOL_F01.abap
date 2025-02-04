*&---------------------------------------------------------------------*
*& Include          ZBC405_D17_SOL_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form init_value
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_value .
    so_car-sign = 'I'.
    so_car-option = 'BT'.
    so_car-low = 'AA'.
    so_car-high = 'QF'.
  
    APPEND so_car.
    CLEAR so_car.
  
    so_car-sign = 'E'.
    so_car-option = 'EQ'.
    so_car-low = 'AZ'.
  
    tab_block-activetab = 'COMM2'.
    tab_block-dynnr = 102.
  
    APPEND so_car.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form set_title
  *&---------------------------------------------------------------------*
  *& 탭, 버튼 이름 지정.
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM set_title .
    gv_txt = 'Hide Details'(p01).
  
    tab1 = 'Flight Connection'(100).
    tab2 = 'Flight'(101).
    tab3 = 'Display flights'(102).
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form check_b2
  *&---------------------------------------------------------------------*
  *& block 2 에 요소 검사
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM check_b2 .
  *  CHECK pa_rad2 = 'X' AND pa_ctry = space.
    IF pa_rad2 = 'X' AND pa_ctry = space.
      MESSAGE e003(bc405).
    ENDIF.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form change_toggle
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM change_toggle .
    CASE sscrfields-ucomm.
      WHEN 'BTN1'.
        IF sy-dynnr = 101.
          IF gv_switch = 1.
            gv_switch = 0.
          ELSE.
            gv_switch = 1.
          ENDIF.
        ENDIF.
    ENDCASE.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form change_button
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM change_button .
    CASE sy-dynnr.
      WHEN 101.
        LOOP AT SCREEN.
          IF screen-group1 = 'DET'.  "2개 이상의 요소를 컨트롤 하고 싶을 때
            " if screen-name cs 'So_START'. "1개의 요소
            screen-active = gv_switch.
            MODIFY SCREEN.
          ENDIF.
          IF gv_switch = 1.
            gv_txt = 'Hide Details'.
          ELSE.
            gv_txt = 'Show Details'.
            CLEAR : so_arr[], so_dep[].
          ENDIF.
        ENDLOOP.
    ENDCASE.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form GET_DATA
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM get_data .
    CASE 'X'.
      WHEN pa_rad1.
        SELECT *
          FROM dv_flights
          INTO CORRESPONDING FIELDS OF TABLE gt_flight
          WHERE carrid IN so_car
          AND connid IN so_con
          AND cityfrom IN so_dep
          AND cityto IN so_arr
          AND fldate IN so_date.
      WHEN pa_rad2.
        SELECT *
          FROM dv_flights
          INTO CORRESPONDING FIELDS OF TABLE gt_flight
          WHERE carrid IN so_car
          AND connid IN so_con
          AND cityfrom IN so_dep
          AND cityto IN so_arr
          AND fldate IN so_date
          AND countryto = dv_flights~countryfr
          AND countryto = pa_ctry.
      WHEN pa_rad3.
        SELECT *
          FROM dv_flights
          INTO CORRESPONDING FIELDS OF TABLE gt_flight
          WHERE carrid IN so_car
          AND connid IN so_con
          AND cityfrom IN so_dep
          AND cityto IN so_arr
          AND fldate IN so_date
          AND countryto <> dv_flights~countryfr.
    ENDCASE.
  ENDFORM.
  
  *&---------------------------------------------------------------------*
  *& Form WRITE_DATA
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM write_data .
    LOOP AT gt_flight INTO gs_flight.
      WRITE : / gs_flight-carrid,
                gs_flight-connid,
                gs_flight-fldate,
                gs_flight-countryto,
                gs_flight-countryfr,
                gs_flight-cityto,
                gs_flight-cityfrom,
                gs_flight-airpfrom,
                gs_flight-price,
                gs_flight-currency,
                gs_flight-seatsmax,
                gs_flight-seatsocc.
    ENDLOOP.
  ENDFORM.
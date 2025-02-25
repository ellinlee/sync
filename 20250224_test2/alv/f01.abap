*&---------------------------------------------------------------------*
*& Include          ZD17_EXAM5_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form change_display
*&---------------------------------------------------------------------*
*& 라디오 버튼에 따라 입력 필드 달라지게 하는 서브루틴.
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM change_display .
  "체크 되어있을 때 case.
  CASE 'X'.

      "pa_book(예매번호로 조회)가 선택되었을 때 로직 처리.
    WHEN pa_book.

      "화면 순회.
      LOOP AT SCREEN.

        "예매 번호 입력 필드 활성화.
        IF screen-group1 = 'BID'.
          screen-active = 1.

          "고객 번호 입력 필드 비활성화.
        ELSEIF screen-group1 = 'CID'.
          screen-active = 0.
        ENDIF.

        "화면을 위에 조건대로 수정.
        MODIFY SCREEN.
      ENDLOOP.

      "pa_cust(고객번호로 조회)가 선택되었을 때 로직 처리.
    WHEN pa_cust.

      "화면 순회.
      LOOP AT SCREEN.
        "고객 번호 입력 필드 활성화.
        IF screen-group1 = 'CID'.
          screen-active = 1.

          "예매 번호 입력 필드 비활성화.
        ELSEIF screen-group1 = 'BID'.
          screen-active = 0.
        ENDIF.

        "화면을 위에 조건대로 수정.
        MODIFY SCREEN.
      ENDLOOP.

  ENDCASE.

ENDFORM.

**&---------------------------------------------------------------------*
**& Form user_command
**&---------------------------------------------------------------------*
**& 화면 상 input(버튼 클릭, 입력) 이루어졌을 떄 처리 로직.
**&---------------------------------------------------------------------*
**&---------------------------------------------------------------------*
*FORM user_command .
*  CASE sscrfields-ucomm.
*
*      "라디오 버튼 클릭되었을 때.
*    WHEN 'DISP'.
*
*      "pa_book(예매번호로 조회)가 선택되었을 때 로직 처리.
*      IF pa_book = 'X'.
*        LOOP AT SCREEN.
*
*          "예매 번호 입력 필드 활성화.
*          IF screen-group1 = 'BID'.
*            screen-active = gv_switch.
*
*            "고객 번호 입력 필드 비활성화.
*          ELSEIF screen-group1 = 'CID'.
*            screen-active = gv_switch.
*          ENDIF.
*
*          "화면을 위에 조건대로 수정.
*          MODIFY SCREEN.
*        ENDLOOP.
*
*        "pa_cust(고객번호로 조회)가 선택되었을 때 로직 처리.
*      ELSE.
*
*        "화면 순회.
*        LOOP AT SCREEN.
*          "고객 번호 입력 필드 활성화.
*          IF screen-group1 = 'BID'.
*            screen-active = 0.
*
*            "예매 번호 입력 필드 비활성화.
*          ELSEIF screen-group1 = 'CID'.
*            screen-active = gv_switch.
*          ENDIF.
*
*          "화면을 위에 조건대로 수정.
*          MODIFY SCREEN.
*        ENDLOOP.
*      ENDIF.
*
*  ENDCASE.
*ENDFORM.

*&---------------------------------------------------------------------*
*& Form change_flag
*&---------------------------------------------------------------------*
*& 라디오 버튼 클릭 시 flag 변수 변경하는 서브루틴.
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM change_flag .

  " 화면 상 input 받았을 떄
  CASE sscrfields-ucomm.

      "라디오 버튼 클릭 시 플래그 값 변경.
    WHEN 'DISP'.

      "flag 값 반대로 변경.
      IF gv_switch = 1.
        gv_switch = 0.
      ELSE.
        gv_switch = 1.
      ENDIF.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& 입력 조건에 맞는 데이터 가져오는 서브루틴.
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM get_data.

  "조건에 따라
  SELECT *
    FROM ztd17_booking AS a
    INNER JOIN ztd17_showtime AS b
    ON a~showtime_id = b~showtime_id
    INTO CORRESPONDING FIELDS OF TABLE gt_booking1
    WHERE a~cust_id IN so_cust
    AND a~book_id IN so_book.


  IF gt_booking1 IS NOT INITIAL.
    "예매 데이터 가공
    LOOP AT gt_booking1 INTO gs_booking1.

      "영화 제목 데이터 가져오기
      SELECT SINGLE *
        FROM ztd17_movie
        INTO CORRESPONDING FIELDS OF gs_booking1
        WHERE movie_id = gs_booking1-movie_id.

      "회원 이름 데이터 가져오기
      SELECT SINGLE *
        FROM ztd17_customer
        INTO CORRESPONDING FIELDS OF gs_booking1
        WHERE cust_id = gs_booking1-cust_id.

      "테이블 수정.
      MODIFY gt_booking1 FROM gs_booking1.

    ENDLOOP.

*    "극장명 데이터 읽기 - for all entries 사용.
*    "테이블 라인 수 계산.
    DESCRIBE TABLE gt_booking1 LINES gv_itab_lines.
*
*    "테이블에 데이터가 없을 시 종료.
    IF gv_itab_lines < 1.
      EXIT.
    ENDIF.
*
*    "for all entries 사용을 위해 정렬 및 중복값 삭제
    SORT gt_booking1 BY theater_id.
    DELETE ADJACENT DUPLICATES FROM gt_booking1 COMPARING ALL FIELDS.

    " 극장명 가져오기
    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE gt_booking_temp
      FROM ztd17_theater
      FOR ALL ENTRIES IN gt_booking1
      WHERE theater_id = gt_booking1-theater_id.

*  " 극장명있는 데이터와 조인해서 가져온 데이터 합쳐 내부 테이블 수정.
    LOOP AT gt_booking1 INTO gs_booking1.
      READ TABLE gt_booking_temp INTO gs_booking_temp WITH KEY theater_id = gs_booking1-theater_id.

      gs_booking1-theater_nm = gs_booking_temp-theater_nm.
      gs_booking1-location = gs_booking_temp-location.

      "테이블 수정.
      MODIFY gt_booking1 FROM gs_booking1.
    ENDLOOP.

    DATA : lv_temp    TYPE string,
           lv_message TYPE string.

    DESCRIBE TABLE gt_booking1 LINES lv_temp.

    CONCATENATE '데이터가 ' lv_temp '건 검색되었습니다.' INTO lv_message SEPARATED BY space.

    MESSAGE lv_message TYPE 'S'.

  ELSE.
    MESSAGE '조건에 맞는 데이터가 없습니다.' TYPE 'I' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.



ENDFORM.


*&---------------------------------------------------------------------*
*& Form init_alv
*&---------------------------------------------------------------------*
*& container 및 alv 객체 생성 서브루틴.
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_alv .

  "container 객체 생성
  CREATE OBJECT go_container
    EXPORTING
      container_name = 'CONTROL_AREA'.             " Name of the Screen CustCtrl Name to Link Container To

  " container 객체 생성 실패 시 에러 메시지 띄우기.
  IF sy-subrc <> 0.
    MESSAGE '객체 생성 실패'(m01) TYPE 'E'.
  ENDIF.

  CREATE OBJECT go_alv_grid
    EXPORTING
      i_parent = go_container.              " Parent Container

  " alv 객체 생성 실패 시 에러 메시지 띄우기.
  IF sy-subrc <> 0.
    MESSAGE '객체 생성 실패'(m01) TYPE 'E'.
  ENDIF.

  "이벤트 핸들러
  SET HANDLER lcl_event_handler=>on_double_click FOR go_alv_grid.
  SET HANDLER lcl_event_handler=>on_toolbar FOR go_alv_grid.
  SET HANDLER lcl_event_handler=>on_user_command FOR go_alv_grid.

  "alv layout 설정.
  PERFORM set_layout.
  "필드카탈로그 설정.
  PERFORM set_field_catalog.
  "정렬 설정.
  PERFORM set_sort.

  "alv 띄우기
  go_alv_grid->set_table_for_first_display(
    EXPORTING
*      i_buffer_active               =                  " Buffering Active
*      i_bypassing_buffer            =                  " Switch Off Buffer
*      i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition
*      i_structure_name              =                  " Internal Output Table Structure Name
      is_variant                    =     gs_variant             " Layout
      i_save                        =      gv_save            " Save Layout
*      i_default                     = 'X'              " Default Display Variant
      is_layout                     =     gs_layout             " Layout
*      is_print                      =                  " Print Control
*      it_special_groups             =                  " Field Groups
*      it_toolbar_excluding          =                  " Excluded Toolbar Standard Functions
*      it_hyperlink                  =                  " Hyperlinks
*      it_alv_graphics               =                  " Table of Structure DTC_S_TC
*      it_except_qinfo               =                  " Table for Exception Quickinfo
*      ir_salv_adapter               =                  " Interface ALV Adapter
    CHANGING
      it_outtab                     = gt_booking1            " Output Table
      it_fieldcatalog               =  gt_field_cat                " Field Catalog
      it_sort                       =   gt_sort               " Sort Criteria
*      it_filter                     =                  " Filter Criteria
*    EXCEPTIONS
*      invalid_parameter_combination = 1                " Wrong Parameter
*      program_error                 = 2                " Program Errors
*      too_many_lines                = 3                " Too many Rows in Ready for Input Grid
*      others                        = 4
  ).
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.


ENDFORM.

*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& alv layout 지정
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM set_layout .
  " variant 설정
  gs_variant-report = sy-cprog.
  gv_save = 'A'.

  "zebra 설정.
  gs_layout-zebra = 'X'.

  "셀 모드 선택.
  gs_layout-sel_mode = 'B'.

  "제목 설정
  gs_layout-grid_title = TEXT-t03.



ENDFORM.

*&---------------------------------------------------------------------*
*& Form set_field_catalog
*&---------------------------------------------------------------------*
*& 필드 카탈로그 설정
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM set_field_catalog .
  gs_field_cat-fieldname = 'BOOK_ID'.
  gs_field_cat-coltext = '예매번호'.
  gs_field_cat-just = 'R'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-key = 'X'.
  gs_field_cat-col_pos = 1.

  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'CUST_ID'.
  gs_field_cat-coltext = '회원ID'.
  gs_field_cat-just = 'L'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-key = 'X'.
  gs_field_cat-col_pos = 2.

  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'CUST_NM'.
  gs_field_cat-coltext = '회원이름'.
  gs_field_cat-just = 'L'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-col_pos = 3.

  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'MOVIE_ID'.
  gs_field_cat-no_out = 'X'.

  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.


  gs_field_cat-fieldname = 'THEATER_ID'.
  gs_field_cat-no_out = 'X'.

  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'THEATER_NM'.
  gs_field_cat-coltext = '극장명'.
  gs_field_cat-just = 'L'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-col_pos = 5.


  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'TITLE'.
  gs_field_cat-coltext = '영화명'.
  gs_field_cat-just = 'L'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-col_pos = 4.


  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'SHOW_DATE'.
  gs_field_cat-coltext = '상영일자'.
  gs_field_cat-just = 'L'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-col_pos = 6.


  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'SHOW_TIME'.
  gs_field_cat-coltext = '상영시간'.
  gs_field_cat-just = 'L'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-col_pos = 7.


  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'BOOK_DATE'.
  gs_field_cat-coltext = '예매일자'.
  gs_field_cat-just = 'L'.
  gs_field_cat-col_opt = 'X'.
  gs_field_cat-col_pos = 8.


  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.


  gs_field_cat-fieldname = 'LOCATION'.
  gs_field_cat-no_out = 'X'.

  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

  gs_field_cat-fieldname = 'RELEASE_DT'.
  gs_field_cat-no_out = 'X'.

  APPEND gs_field_cat TO gt_field_cat.
  CLEAR gs_field_cat.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form set_sort
*&---------------------------------------------------------------------*
*& 정렬
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM set_sort .
  "예매 번호 정렬
  gs_sort-fieldname = 'BOOK_ID'.
  gs_sort-up = 'X'.               "오름차순 (default)
  gs_sort-spos = 1.

  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.

  "회원ID 정렬
  gs_sort-fieldname = 'CUST_ID'.
  gs_sort-up = 'X'.               "오름차순 (default)
  gs_sort-spos = 2.

  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.

  "회원이름 정렬
  gs_sort-fieldname = 'CUST_NM'.
  gs_sort-up = 'X'.               "오름차순 (default)
  gs_sort-spos = 3.

  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form on_double_click
*&---------------------------------------------------------------------*
*& 더블 클릭 이벤트
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM on_double_click  USING  ps_row_no TYPE lvc_s_roid.
  DATA : lv_text    TYPE dd07v-ddtext,
         lv_message TYPE string.


  DATA : lv_temp TYPE dd07v-domvalue_l.


  READ TABLE gt_booking1 INTO gs_booking1 INDEX ps_row_no-row_id.

  lv_temp = gs_booking1-location.

  IF sy-subrc <> 0.
    MESSAGE TEXT-t04 TYPE 'E'.
  ENDIF.

  CALL METHOD zcl_get_dom_text_d17=>get_location
    EXPORTING
      iv_loca    = lv_temp
    IMPORTING
      ev_loca_nm = lv_text
    EXCEPTIONS
      no_data    = 1
*     others     = 2
    .

  IF sy-subrc <> 0.
    MESSAGE TEXT-t04 TYPE 'E'.
  ELSE.
    lv_message = '선택하신 극장의 지역은 [' && lv_text && ']입니다.'.
    MESSAGE lv_message TYPE 'I'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form on_toolbar1
*&---------------------------------------------------------------------*
*& 툴바 이벤트
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM on_toolbar1  USING pe_object TYPE REF TO cl_alv_event_toolbar_set.
  " work area 선언
  DATA : ls_button TYPE stb_button.

  "SEPERATOR
  ls_button-butn_type = '3'.

  INSERT ls_button INTO TABLE pe_object->mt_toolbar.
  CLEAR ls_button.

  "개봉일 버튼
  ls_button-function = 'OPEN'.          "4-5자리 길이로 줄여도 OK
  ls_button-butn_type = '0'.
  ls_button-text = '개봉일'.

  INSERT ls_button INTO TABLE pe_object->mt_toolbar.
  CLEAR ls_button.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form on_user_command
*&---------------------------------------------------------------------*
*& 화면 상 인풋 관리
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM on_user_command  USING pv_ucomm TYPE sy-ucomm.

  "함수용 변수
  DATA : lt_row_no TYPE lvc_t_roid,
         ls_row_no TYPE LINE OF lvc_t_roid.

  DATA : lv_message TYPE string.
  DATA : lv_date TYPE string.


  CASE pv_ucomm.
    WHEN 'OPEN'.
      go_alv_grid->get_selected_rows(
        IMPORTING
*        et_index_rows =                  " Indexes of Selected Rows
          et_row_no     =  lt_row_no            " Numeric IDs of Selected Rows
      ).
      LOOP AT lt_row_no INTO ls_row_no.
        READ TABLE gt_booking1 INTO gs_booking1 INDEX ls_row_no-row_id.

        CONCATENATE gs_booking1-release_dt(4) gs_booking1-release_dt+4(2) gs_booking1-release_dt+6(2) INTO lv_date SEPARATED BY '.'.

        CONCATENATE '해당 영화의 개봉일은 ' lv_date '입니다.' INTO lv_message SEPARATED BY space.

        MESSAGE lv_message TYPE 'I'.
      ENDLOOP.

  ENDCASE.



ENDFORM.
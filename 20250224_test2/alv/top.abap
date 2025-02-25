*&---------------------------------------------------------------------*
*& Include          ZD17_EXAM5_TOP
*&---------------------------------------------------------------------*


* select-options 입력 변수를 위해 변수 선언.
TABLES : ztd17_booking.


* Fields on selection screens structure 선언.
TABLES : sscrfields.

* type 재선언.
TYPES : BEGIN OF gty_booking,
          mandt      TYPE mandt,
          book_id    TYPE ztd17_booking-book_id,
          cust_id    TYPE ztd17_booking-cust_id,
          cust_nm    TYPE ztd17_customer-cust_nm,
          movie_id   TYPE ztd17_movie-movie_id,
          release_dt TYPE ztd17_movie-release_dt,
          theater_id TYPE ztd17_theater-theater_id,
          location   TYPE ztd17_theater-location,
          theater_nm TYPE ztd17_theater-theater_nm,
          title      TYPE ztd17_movie-title,
          show_date  TYPE ztd17_showtime-show_date,
          show_time  TYPE ztd17_showtime-show_time,
          book_date  TYPE ztd17_booking-book_date.


TYPES : END OF gty_booking.

"for all entries를 위한 내부 변수 선언.
DATA : gt_booking1 TYPE TABLE OF gty_booking,
       gs_booking1 TYPE gty_booking.

* 사용자의 input에 대한 변수 선언.
DATA : ok_code TYPE sy-ucomm.

* 조건에 따른 데이터 가져올 work area 및 alv 선언.
DATA : gt_booking_temp TYPE TABLE OF gty_booking,
       gs_booking_temp TYPE gty_booking.

* 라인 수 위한 변수 선언
DATA : gv_itab_lines TYPE i.



* 라디오 버튼 클릭에 대한 flag 변수 선언.
DATA : gv_switch TYPE i VALUE 1.

* ALV 출력을 위한 참조 변수 선언.
DATA  : go_container TYPE REF TO cl_gui_custom_container,      "custom container
        go_alv_grid  TYPE REF TO cl_gui_alv_grid.             "alv_grid

* layout variant 설정을 위한 변수 선언.
DATA : gs_variant TYPE disvariant,
       gv_save.

* layout 설정을 위한 변수 선언.
DATA : gs_layout TYPE lvc_s_layo.

* 컬럼 속성 변경을 위한 work area 및 internal table 선언.
DATA : gt_field_cat TYPE lvc_t_fcat,
       gs_field_cat TYPE lvc_s_fcat.

" Sort를 위한 work area 및 internal table 선언.
DATA : gt_sort TYPE lvc_t_sort,
       gs_sort TYPE lvc_s_sort.
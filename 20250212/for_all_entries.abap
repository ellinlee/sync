*&---------------------------------------------------------------------*
*& Report ZD17_FOR_ALL_ENTRIES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_for_all_entries.

INCLUDE bc405_select_d5_top.

DATA : go_alv_table TYPE REF TO cl_salv_table.

DATA : gv_line TYPE i.

DATA : BEGIN OF gs_carr,
         carrid TYPE spfli-carrid,
         connid TYPE spfli-connid,
       END OF gs_carr.

DATA : gt_carr LIKE TABLE OF gs_carr.

*--------------------------------------------------------------------*
*START-OF-SELECTION.
*--------------------------------------------------------------------*

START-OF-SELECTION.

*- 1. spfli로 부터 선택 화면 조건으로부터 가져오기.
  SELECT carrid connid cityfrom airpfrom cityto airpto deptime arrtime
    INTO TABLE gt_spfli
    FROM spfli
*    WHERE cityfrom = 'NEW YORK'.
    WHERE cityfrom IN so_cityf
    AND cityto IN so_cityt.

  " 이후 로직에 원 테이블의 데이터 유실 없이 보존하고 조건으로 활용하고자하는 인터널 테이블을 추가 생성하여 활용한다.
*  LOOP AT gt_spfli INTO gs_spfli.
*    MOVE-CORRESPONDING gs_spfli TO gs_carr.
*    APPEND gs_carr TO gt_carr.                "gt_carr로 조건 체크
*  ENDLOOP.


*- 1.1 데이터 존재 유무 확인.
** 1st way
*  IF gt_spfli IS INITIAL.
*    EXIT.
*  ENDIF.

** 2nd way - 바로 위에 select가 있어야 함 ! 그래야 의미가 있음
*  IF sy-subrc <> 0.
*    EXIT.
*  ENDIF.

** 3rd way
*IF lines( gt_spfli ) = 0 .
*  exit.
*ENDIF.

** 4th way
  DESCRIBE TABLE gt_spfli LINES gv_line.
  IF gv_line = 0.
    EXIT.
  ENDIF.

**우회
*  DESCRIBE TABLE gt_carr LINES gv_line.
*  IF gv_line = 0.
*    EXIT.
*  ENDIF.


*- 1.2 sort : 중복제거 -> 효율적임.
  SORT gt_spfli.
*SORT gt_spfli by carrid connid "위 코드와 동일 -> 조건에 참여하는 필드로만 구성
**우회
*  SORT gt_carr.


*- 1.3 중복제거.
  DELETE ADJACENT DUPLICATES FROM gt_spfli. " comparing carrid
**우회
*  DELETE ADJACENT DUPLICATES FROM gt_carr. " comparing carrid


*- 2. get data from sflight table
  SELECT carrid connid fldate seatsmax seatsocc
    INTO TABLE gt_flights
    FROM sflight
    FOR ALL ENTRIES IN gt_carr "from 1 condition internal table
    WHERE carrid = gt_carr-carrid
    AND connid = gt_carr-connid.


*- 2. GET data from sflight table
**우회
*SELECT carrid connid fldate seatsmax seatsocc
*INTO TABLE gt_flights
*FROM sflight
*FOR ALL ENTRIES IN gt_spfli "from 1 condition internal table
*WHERE carrid = gt_spfli-carrid
*AND connid = gt_spfli-connid.


  cl_salv_table=>factory(
*      EXPORTING
*        list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*        r_container    =                           " Abstract Container for GUI Controls
*        container_name =
    IMPORTING
      r_salv_table   =   go_alv_table                        " Basis Class Simple ALV Tables
    CHANGING
      t_table        = gt_flights
  ).
*    CATCH cx_salv_msg. " ALV: General Error Class with Message

  go_alv_table->display( ).
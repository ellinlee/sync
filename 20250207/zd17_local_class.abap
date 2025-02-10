*&---------------------------------------------------------------------*
*& Report ZD17_LOCAL_CLASS0
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_local_class0.


*--------------------------------------------------------------------*
*& TOP
*--------------------------------------------------------------------*
DATA : gs_scar TYPE scarr.
*DATA : lo_message TYPE REF TO lcl_message.  "못알아먹음.
DATA : go_alv TYPE REF TO cl_gui_alv_grid.

*forward declaration
CLASS : lcl_message  DEFINITION DEFERRED. "public
DATA : lo_message TYPE REF TO lcl_message.  "참조 변수
DATA : gv_info TYPE c.

*--------------------------------------------------------------------*
*&클래스 정의 : INCLUDE C01로 다시 정의
*--------------------------------------------------------------------*

*1. CLASS 정의 (속성, 메소드)
CLASS lcl_message DEFINITION.

  PUBLIC SECTION. "visibility (public -> protected -> private 순으로 코드를 작성해야 함)
    " method
    "instance
    METHODS : display_message.
    "정적 method
    CLASS-METHODS : call_message.

    " instance 속성
    DATA : mt_info TYPE c.
    "static 속성
    CLASS-DATA : ct_info TYPE c.

  PROTECTED SECTION.    "상속 관계 클래스에만 공개.

  PRIVATE SECTION.      "해당 클래스에서만 공개.
    DATA : mv_data TYPE i.

ENDCLASS.

* 2. 로컬 클래스 구현 (메소드의 구현 부분)
CLASS lcl_message IMPLEMENTATION.
  METHOD display_message.
    WRITE : / '안녕하세요.'.
  ENDMETHOD.

  METHOD call_message.
    ct_info = 'X'.
  ENDMETHOD.

ENDCLASS.

*3. 객체 생성
START-OF-SELECTION.

*  DATA : lo_message TYPE REF TO lcl_message.    "참조 변수
  CREATE OBJECT lo_message. "객체 생성


  lo_message->display_message( ).     "메소드 호출 - short form
*  call METHOD lo_message->display_message( ).
  lo_message->call_message( ).

  gv_info = lo_message->ct_info.    "속성값 접근

  WRITE : / gv_info.
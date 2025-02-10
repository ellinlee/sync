*&---------------------------------------------------------------------*
*& Report ZD17_LOCAL_CLASS1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZD17_LOCAL_CLASS1.

DATA : gv_val TYPE i.
gv_val = 10.

**********************************************************************
* Class 정의 : DEFINITION
**********************************************************************
CLASS lcl_example DEFINITION.

  PUBLIC SECTION.

    DATA : gv_value TYPE i.
    CLASS-DATA : cv_value TYPE c.

*- 생성자
    CLASS-METHODS : class_constructor.               "정적 생성자 (매개변수 X), 프로그램 실행되자마자 실행됨
    METHODS constructor IMPORTING iv_value TYPE i.   "생성자, IMPORTING만 갖고있음

    METHODS get_data IMPORTING iv_value TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA : mv_data TYPE i.
    DATA : mv_make TYPE string.

ENDCLASS.
**********************************************************************
* Class 구현  : IMPLEMENTATION
**********************************************************************
CLASS lcl_example IMPLEMENTATION.

  METHOD class_constructor.

    WRITE : /'class_constructor'.

  ENDMETHOD.

  METHOD constructor.

    gv_value = iv_value.  "매개변수로 받은 값을 클래스의 public 영역에 정의된 속성에 전달한다.
    WRITE : gv_value.

  ENDMETHOD.

  METHOD get_data.

    mv_data = iv_value.   "매개변수로 받은 값을 클래스 내부의 private 영역의 속성에 전달한다.
    WRITE mv_data.

  ENDMETHOD.


ENDCLASS.




START-OF-SELECTION.

  DATA : lo_example TYPE REF TO lcl_example.

  CREATE OBJECT lo_example
    EXPORTING
      iv_value = gv_val.

  lo_example->get_data( iv_value = 5 ).
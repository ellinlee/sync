*&---------------------------------------------------------------------*
*& Report ZD17_EXAM2
*&---------------------------------------------------------------------*
*& Selection screen 구성하기
*&---------------------------------------------------------------------*
REPORT zd17_exam2.

*-1. table 타입 활용해 sflight와 이름이 같은 structure 선언 (구조만 갖고 옴).
TABLES: sscrfields, scarr, saplane, sbuspart, stravelag.


*-2. Application toolbar 에 버튼 자리 선언
SELECTION-SCREEN FUNCTION KEY 1.   "FC01
SELECTION-SCREEN FUNCTION KEY 2.   "FC02

*-3. 입력 변수 선언.
**-3.1. b1 에 Airline ID (initial value) 선언.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.     "Selection Condition

  SELECT-OPTIONS : so_carr1 FOR scarr-carrid.                    "Airline ID (initial value)

SELECTION-SCREEN END OF BLOCK b1.

**-3.2. b2 에 Flight Type, Producer, Airline ID 선언.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02 NO INTERVALS. "No interval Block.

  PARAMETERS :     pa_flty  TYPE saplane-planetype.       "Flight Type
  SELECT-OPTIONS : so_prod FOR saplane-producer,          "Producer
                   so_carr2 FOR scarr-carrid.             "Airline ID

SELECTION-SCREEN END OF BLOCK b2.

**-3.3. 한 줄에 입력 번수 선언.
*** 한 줄에 Airline ID, Airline Name 입력 변수 선언.
SELECTION-SCREEN BEGIN OF LINE.

  SELECTION-SCREEN COMMENT 2(10) TEXT-001 FOR FIELD pa_carr3.  "Airline ID
  PARAMETERS : pa_carr3  LIKE scarr-carrid OBLIGATORY.         "Airline ID

  SELECTION-SCREEN COMMENT 19(15) TEXT-002 FOR FIELD pa_cname.  "Airline Name
  PARAMETERS : pa_cname LIKE scarr-carrname.                    "Airline Name

SELECTION-SCREEN END OF LINE.

**-3.4.한 줄 띄우기. 한 줄 그리고 또 한 줄 띄우기.
SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN ULINE.
SELECTION-SCREEN SKIP 1.


*-3.5.b3 안에 Flight Partner Name과  b4 선언.
** b4 안에 Travel Agency Number, Travel agency local currency 선언.
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-t03.   "Airline Partner

  PARAMETERS :     pa_parna  TYPE sbuspart-buspartnum.          "Flight Partner Name

  SELECTION-SCREEN SKIP 1.
  SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-t04. "Business Partner Type

    SELECT-OPTIONS : so_agnum FOR stravelag-agencynum.          "Travel Agency Number
    PARAMETERS : pa_locur TYPE stravelag-currency MATCHCODE OBJECT rscurrency.              "Travel agency local currency

  SELECTION-SCREEN END OF BLOCK b4.

SELECTION-SCREEN END OF BLOCK b3.

*-4. 추가 버튼 정의.
SELECTION-SCREEN PUSHBUTTON 1(40) TEXT-003 USER-COMMAND btn1.       "Push Me!!!

*-5. 새 screen 정의.
SELECTION-SCREEN BEGIN OF SCREEN 1100 TITLE TEXT-t05.               "Call 1100 screen
  PARAMETERS : pa_date TYPE sy-datum DEFAULT sy-datum.
SELECTION-SCREEN END OF SCREEN 1100.


*-6.INITIALIZATION.
INITIALIZATION.

**-6.1. 버튼 설정 (텍스트 및 아이콘).
  MOVE icon_default_windows TO sscrfields-functxt_01.            "icon 설정.
  CONCATENATE  icon_create TEXT-b01 INTO sscrfields-functxt_02.  "icon과 text 합쳐 display.

**-6.2. airline code range 설정.
***-6.2.1. carrid= `AA`
  so_carr1-sign = 'I'.
  so_carr1-option = 'EQ'.
  so_carr1-low = 'AA'.

***-6.2.1.1. 추가 후 삭제 .
  APPEND so_carr1.
  CLEAR so_carr1.

***-6.2.2  carrid가 'AC'~'AZ'.
  so_carr1-sign = 'I'.
  so_carr1-option = 'BT'.
  so_carr1-low = 'AC'.
  so_carr1-high = 'AZ'.

***-6.2.2. 추가 후 삭제 .
  APPEND so_carr1.
  CLEAR so_carr1.

***-6.2.3. carrid <> LT (LT제외).
  so_carr1-sign = 'E'.
  so_carr1-option = 'EQ'.
  so_carr1-low = 'LT'.

  APPEND so_carr1.
  CLEAR so_carr1.

*-7. AT SELECTION-SCREEN.
AT SELECTION-SCREEN.

**-7.1. application toolbar에서 첫 번째 버튼.
  IF sscrfields-ucomm = 'FC01'.
    CALL SELECTION-SCREEN 1100             "새 화면 불러오기.
         STARTING AT 5 5                   "좌표 지정.
         ENDING AT 50 10.
  ENDIF.

**7.2. "Push Me!!! 버튼 클릭.
  IF sscrfields-ucomm = 'BTN1'.
    MESSAGE '두번째 버튼 기능도 완성!!' TYPE 'I'.      "메세지 띄우기.
  ENDIF.
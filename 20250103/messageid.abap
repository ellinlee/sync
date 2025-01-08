*&---------------------------------------------------------------------*
*& Report ZD17_MESSAGE
*&---------------------------------------------------------------------*
*& 메세지 클래스 SE91 테이블 t100에 저장
*& ------------------------------------------------------------
*&---------------------------------------------------------------------*
REPORT zd17_message MESSAGE-ID demo.  "message class demo만 사용할 것이다라고 명시

*- 1. message id 없는 사용 형식
"MESSAGE '메세지id가 없습니다.' TYPE 'I'.
MESSAGE '메세지id가 없습니다.' TYPE 'E' DISPLAY LIKE 'S' "타입은 e인데 메세지는 s로 표현됨.


* -2. message id 있는 사용 형식 (글로벌)
*MESSAGE w001 WITH 'Test'.     "with 뒤는 &으로 대체
*MESSAGE w002 WITH 'Test'.     "with 뒤는 &으로 대체
*MESSAGE w003 WITH 'Test'.     "with 뒤는 &으로 대체
*MESSAGE w004 WITH 'Test'.     "with 뒤는 &으로 대체
*MESSAGE x007 WITH 'Test'.     "with 뒤는 &으로 대체
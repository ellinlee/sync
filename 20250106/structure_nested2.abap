*&---------------------------------------------------------------------*
*& Report ZBC430_D17_STRUCT_NESTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc430_d17_struct_nested.

* -1. data 선언 - zperson_d17 참조해 선언
DATA : gs_person TYPE zperson_d17.

* -2. data 지정 및 출력
**시작
START-OF-SELECTION.

** 값 지정
  gs_person-name-firstname = 'Alexandor Arnold'.
  gs_person-name-lastname = 'Trent'.
  gs_person-street = 'Liverpool str.'.
  gs_person-nr = '245'.
  gs_person-zip = '19834'.
  gs_person-city = 'Liverpool'.

** 출력
  WRITE: 'First name: ', gs_person-name-firstname.
  WRITE: / 'Last name: ', gs_person-name-lastname.
  WRITE: / 'Street: ', gs_person-street.
  WRITE: / 'Street number: ', gs_person-nr.
  WRITE: / 'Postal code: ', gs_person-zip.
  WRITE: / 'City: ', gs_person-city.
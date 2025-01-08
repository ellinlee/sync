*&---------------------------------------------------------------------*
*& Report ZBC430_D17_STRUCT_DEEP
*&---------------------------------------------------------------------*
*& Deep Structure
*&---------------------------------------------------------------------*
REPORT zbc430_d17_struct_deep.

* Data 선언
DATA : gt_person TYPE zperson_d17,
       gs_phone  LIKE LINE OF gt_person-phone.

* 시작
START-OF-SELECTION.

** 데이터 입력
  gt_person-name-firstname = 'Eunchae'.
  gt_person-name-lastname = 'Lee'.
  gt_person-city = 'Seoul'.
  gt_person-nr = '42'.
  gt_person-street = 'gaja-ro'.
  gt_person-zip = '22311'.

  gs_phone-p_number = '010-1111-1111'.
  INSERT gs_phone INTO TABLE gt_person-phone.

  gs_phone-p_number = '010-3333-3333'.
  INSERT gs_phone INTO TABLE gt_person-phone.

  gs_phone-p_number = '010-2222-2222'.
  INSERT gs_phone INTO TABLE gt_person-phone.

** 데이터 출력
  WRITE : / gt_person-name-firstname(7), gt_person-name-lastname(3),         " 공백 제거를 위해 문자열 일부만 포함
          / gt_person-city,
          / gt_person-nr,
          / gt_person-street,
          / gt_person-zip.

WRITE : / , 'Phone Number List', / .

  LOOP AT gt_person-phone into gs_phone.
      WRITE : / gs_phone-p_number.
  ENDLOOP.
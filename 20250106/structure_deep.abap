DATA wa_pers TYPE person.   "structure 형태로 work area 선언
DATA wa_tel LIKE (LINE of) wa_pers-telephone.    "wa의 하나의 데이터 필드
"LIKE TABLE OF : TABLE 참조

wa_pers-name-firstname = 'walter'.
wa_pers-name-lastname = 'Scheweizer'.

wa-tel-number = '+01012345678'.
INSERT wa_tel INTO TABLE wa_pers-telephone.

wa_tel-number  = '+0109887772321'.
INSERT wa_tel INTO TABLE wa_pers-telephone.

READ TABLE wa_pers-telephone INDEX 1 into wa_tel 
" index 1 인 데이터 읽어 변수에 넣기 - 첫 번째에 넣은 전화번호에 해당

" 테이블에 데이터는 총 2개 들어간 상태
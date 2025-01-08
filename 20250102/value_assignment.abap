CONSTANTS gc_qf TYPE s_carr_id value 'QF'.
"s_carr_id: 3자리 char
DATA : gv_carrid1 TYPE s_carr_id,          "NULL 값
			 gv_carrid2 TYPE s_carr_id VALUE 'LH',
			 gv_count TYPE i.
			 
MOVE gs_qf TO gv_carrid1.    "gs_qf에 QF 할당
gv_carrid2 = gv_carrid1.     "gv_carrid2에 gv_carrid1 값 할당ㄷ
gv_count = gv_count + 1.     "gv_count에 0+1=1 할당

CLEAR : gv_carrid1, gv_carrid2, gv_count. "값 초기화 
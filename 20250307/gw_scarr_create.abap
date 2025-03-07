  METHOD zcarr_d17set_create_entity.

    "io_data_provider: 데이터 들어오는 곳.
    DATA : ls_gw TYPE zcl_zcarr_d17_mpc=>ts_scarr_d17. "gateway에서 사용하는 모델의 구조.
    DATA : ls_data TYPE zcarr_D17.    "입력할 데이터 구조.

    "데이터 받기 - 바디의 정보를 가져오기 - json 파일이 옴
    io_data_provider->read_entry_data(
      IMPORTING
        es_data = ls_gw
    ).
*    CATCH /iwbep/cx_mgw_tech_exception. " mgw technical exception

    "db형태로 환원 필요.
    "db에 입력할 WA 데이터 생성.
    MOVE-CORRESPONDING ls_gw TO ls_data.

    "데이터 삽입
    INSERT zcarr_d17 FROM ls_data.

    "데이터 전달이 잘 되었다면 returning 되는 곳에 전달.(결과 반환)
    IF sy-subrc = 0.
      MOVE-CORRESPONDING ls_data TO er_entity.
    ENDIF.

  ENDMETHOD.
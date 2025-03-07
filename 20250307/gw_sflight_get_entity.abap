METHOD sflightset_get_entity.

  DATA : ls_key_tab TYPE LINE OF /iwbep/t_mgw_name_value_pair.

  DATA : lv_carrid TYPE sflight-carrid,
         lv_connid TYPE sflight-connid,
         lv_fldate TYPE sflight-fldate.

  LOOP AT it_key_tab INTO ls_key_tab.
    IF ls_key_tab-name = 'Carrid'.
      lv_carrid = ls_key_tab-value.
    ENDIF.
    IF ls_key_tab-name = 'Connid'.
      lv_connid = ls_key_tab-value.
    ENDIF.
    IF ls_key_tab-name = 'Fldate'.
      lv_fldate = ls_key_tab-value.
    ENDIF.
  ENDLOOP.

  SELECT SINGLE * FROM sflight INTO CORRESPONDING FIELDS OF er_entity
    WHERE carrid = lv_carrid AND connid = lv_connid AND fldate = lv_fldate.
ENDMETHOD.
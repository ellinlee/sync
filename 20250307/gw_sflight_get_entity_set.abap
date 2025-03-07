  METHOD sflightset_get_entityset.
    IF iv_filter_string IS INITIAL.
      SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE et_entityset.
    ELSE.
      SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE et_entityset
        WHERE (iv_filter_string).
    ENDIF.
  ENDMETHOD.
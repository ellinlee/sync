*&---------------------------------------------------------------------*
*& Report ZD17_INNER_JOIN_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zd17_inner_join_3.

TYPES : BEGIN OF gty_join,
          carrid   TYPE scarr-carrid,
          carrname TYPE scarr-carrname,
          connid   TYPE spfli-connid,
          cityfrom TYPE spfli-cityfrom,
          cityto   TYPE spfli-cityto,
          fldate   TYPE sflight-fldate,
          seatsmax TYPE sflight-seatsmax,
          seatsocc TYPE sflight-seatsocc,
        END OF gty_join.

DATA : gt_join TYPE TABLE OF gty_join.

DATA : go_alv_table TYPE REF TO cl_SALV_TABLE.

PARAMETERS : pa_carr TYPE s_carr_id.

*--------------------------------------------------------------------*
*START-OF-SELECTION.
*--------------------------------------------------------------------*
START-OF-SELECTION.

  SELECT a~carrid, a~carrname,
         b~connid, b~cityfrom, b~cityto,
         c~fldate, c~seatsmax, c~seatsocc

    INTO CORRESPONDING FIELDS OF TABLE @gt_join

    FROM scarr AS a
    INNER JOIN spfli AS b
      ON a~carrid = b~carrid
    INNER JOIN sflight AS c
      ON b~carrid = c~carrid
      AND b~connid = b~connid

    WHERE a~carrid = @pa_carr
    and seatsocc < c~seatsmax

    ORDER BY a~carrid, b~connid, c~fldate.


    cl_salv_table=>factory(
*      EXPORTING
*        list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*        r_container    =                           " Abstract Container for GUI Controls
*        container_name =
      IMPORTING
        r_salv_table   = go_alv_table                        " Basis Class Simple ALV Tables
      CHANGING
        t_table        = gt_join
    ).
*    CATCH cx_salv_msg. " ALV: General Error Class with Message


    go_alv_table->display( ).
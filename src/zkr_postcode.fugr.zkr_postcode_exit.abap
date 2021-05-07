FUNCTION ZKR_POSTCODE_EXIT.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     VALUE(SHLP) TYPE  SHLP_DESCR
*"     VALUE(CALLCONTROL) LIKE  DDSHF4CTRL STRUCTURE  DDSHF4CTRL
*"--------------------------------------------------------------------
TYPES:
    BEGIN OF lty_stru_list,
*   add fields for the selection list here
      zonecode           TYPE ad_pstcd1,
      roadaddress        TYPE text100,
      roadaddressenglish TYPE text100,
      kr60               TYPE ad_street,
      kr40               TYPE ad_city1,
      en60               TYPE ad_street,
      en40               TYPE ad_city1,
    END OF lty_stru_list.
  DATA: lt_select_list TYPE STANDARD TABLE OF lty_stru_list,
        ls_select_list LIKE LINE OF lt_select_list.

  CHECK: callcontrol-step EQ 'SELECT'." OR callcontrol-step EQ 'SELONE'.

  CLEAR: gs_addr.

  IF wdr_task=>application IS INITIAL.
    CALL SCREEN 1000.
  ENDIF.

  IF gs_addr IS INITIAL.
    callcontrol-step = 'EXIT'.
    RETURN.
  ENDIF.


  callcontrol-step = 'RETURN'.
  MOVE-CORRESPONDING gs_addr TO ls_select_list.
  APPEND ls_select_list TO lt_select_list.

* map
  CALL FUNCTION 'F4UT_RESULTS_MAP'
    TABLES
      shlp_tab    = shlp_tab
      record_tab  = record_tab
      source_tab  = lt_select_list
    CHANGING
      shlp        = shlp
      callcontrol = callcontrol.





ENDFUNCTION.

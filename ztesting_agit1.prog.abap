*&---------------------------------------------------------------------*
*& Report  ztesting_agit1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ztesting_agit1.

DATA lv_tstmp_strt TYPE string.
DATA lv_tstmp_end_somo TYPE /somo/jobmon18-tracetimstfrom.
DATA lv_tstmp_strt_somo TYPE /somo/jobmon18-tracetimstfrom.
DATA TRACE_INFO TYPE  /SOMO/MA_T_TRACE_INFO.
DATA: lt_jobmon14  TYPE /SOMO/MA_T_METRIC_DATA.

DATA(ls_sy) = sy.

CONCATENATE sy-datlo sy-uzeit INTO lv_tstmp_strt.

lv_tstmp_end_somo = '20180716082219'.
lv_tstmp_strt_somo = '20180715082219'.

CALL FUNCTION '/SOMO/READ_TRACE_INFO'
  EXPORTING
    solman_sid    = 'FA7'
    solman_instno = '0020270862'
    context       = 'DATACOLL'
    from_time     = lv_tstmp_strt_somo
    to_time       = lv_tstmp_end_somo
  TABLES
    trace_info    = TRACE_INFO
 EXCEPTIONS
   NO_DATA_FOUND = 1
   OTHERS        = 2
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ELSE.
  DELETE TRACE_INFO WHERE context_id <> '6CAE8B77A8BE1EE89FD05AD76AB04944'.
  BREAK-POINT.

  SORT TRACE_INFO BY cntr DESCENDING.

  LOOP AT TRACE_INFO INTO DATA(ls_trace_info).
    WRITE ls_trace_info-text.
    WRITE: /.
  ENDLOOP.
ENDIF.


CALL FUNCTION '/SOMO/UNIJOBMON_CHECK_COLL'
  EXPORTING
    iv_solman_sid                 = 'FA7'
    iv_solman_instno              = '0020270862'
    iv_context_id                 = '6CAE8B77A8BE1EE89FD05543630A0940'
*   IV_SCHEDULEDATE               =
 IMPORTING
*  ES_JOBMON15_MONID_PARAM       =
*   ET_MA_MAPPING                 =
*   ET_JOBMON04                   =
*   ET_JOBMON07_PARAM             =
*   ET_JOBMON07_METRICS           =
*   ET_JOBMON11                   =
*   ET_JOBMON12                   =
   ET_JOBMON14                   = lt_jobmon14
*   ET_JOBMON17_MONID_LIST        =
*   ET_JOBMON17_CALL_LIST         =
* TABLES
*   ET_JOBMON01                   =
* EXCEPTIONS
*   NO_DATA_FOUND                 = 1
*   OTHERS                        = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
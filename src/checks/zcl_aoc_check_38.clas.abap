CLASS zcl_aoc_check_38 DEFINITION
  PUBLIC
  INHERITING FROM zcl_aoc_super
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor.

    METHODS check
        REDEFINITION.
    METHODS get_message_text
        REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AOC_CHECK_38 IMPLEMENTATION.


  METHOD check.

* abapOpenChecks
* https://github.com/larshp/abapOpenChecks
* MIT License

    DATA: lv_include   TYPE sobj_name.

    FIELD-SYMBOLS: <ls_statement> LIKE LINE OF io_scan->statements,
                   <ls_token>     LIKE LINE OF io_scan->tokens.


    LOOP AT io_scan->statements ASSIGNING <ls_statement>.

      READ TABLE io_scan->tokens ASSIGNING <ls_token> INDEX <ls_statement>-from.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      IF <ls_token>-str = 'ENDSELECT'.
        lv_include = io_scan->get_include( <ls_statement>-level ).

        inform( p_sub_obj_name = lv_include
                p_line         = <ls_token>-row
                p_kind         = mv_errty
                p_test         = myname
                p_code         = '001' ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( ).

    version        = '001'.
    position       = '038'.

    has_attributes = abap_true.
    attributes_ok  = abap_true.

    enable_rfc( ).

  ENDMETHOD.


  METHOD get_message_text.

    CLEAR p_text.

    CASE p_code.
      WHEN '001'.
        p_text = 'Avoid use of SELECT-ENDSELECT'.           "#EC NOTEXT
      WHEN OTHERS.
        super->get_message_text( EXPORTING p_test = p_test
                                           p_code = p_code
                                 IMPORTING p_text = p_text ).
    ENDCASE.

  ENDMETHOD.                    "GET_MESSAGE_TEXT
ENDCLASS.

*&---------------------------------------------------------------------*
*& Report z_ccm_pricing_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ccm_mqf_pricing_01.



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KONV Examples
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Test cases for KONV quickfixes
"
    TYPES: BEGIN OF ty_konv_cust. TYPES abc TYPE c. INCLUDE STRUCTURE konv. TYPES END OF ty_konv_cust.
"
TABLES: konv.
"
DATA: ls_konv       TYPE konv, ls_konv_cust TYPE ty_konv_cust,
      l_datum       TYPE dats, lt_konv_cust TYPE STANDARD TABLE OF ty_konv_cust,
      iv_where      TYPE konv, lt_konv TYPE STANDARD TABLE OF konv,
      lv_value      TYPE STANDARD TABLE OF konv, lv_konv_krech TYPE konv-krech.












"Test case #1  KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL37C0R8844) ).
KONV = ETL37C0R8844[ 1 ].
CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.





















"Test case #2  KONV
SELECT SINGLE kreli FROM PRCD_ELEMENTS INTO CORRESPONDING FIELDS OF konv.











"Test case #3  KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL73C0R7909) ).
  TYPES: BEGIN OF TYL73C0R3451,
    KRELI TYPE KONV-KRELI,
    KDATU TYPE KONV-KDATU,
  END OF TYL73C0R3451.
  DATA LML73C0R2528 TYPE TYL73C0R3451.
  LML73C0R2528-KRELI = ETL73C0R7909[ 1 ]-KRELI.
  LML73C0R2528-KDATU = ETL73C0R7909[ 1 ]-KDATU.
  MOVE-CORRESPONDING LML73C0R2528 TO KONV.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #4  KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 ( fieldname = 'KDATU' value = L_DATUM )
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL86C0R3518) ).
  TYPES: BEGIN OF TYL86C0R3238,
    KRELI TYPE KONV-KRELI,
  END OF TYL86C0R3238.
  DATA LML86C0R4997 TYPE TYL86C0R3238.
  LML86C0R4997-KRELI = ETL86C0R3518[ 1 ]-KRELI.
  MOVE-CORRESPONDING LML86C0R4997 TO KONV.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











*"Test case #5  KONV with "IN"
*select single * from konv where kreli in ( '001' ).











"Test case #6  KONV API: Only = in where clause
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 ( fieldname = 'KNUMV' value = IV_WHERE-KNUMV )
 ( fieldname = 'KSCHL' value = IV_WHERE-KSCHL )
 ( fieldname = 'KDATU' value = IV_WHERE-KDATU )
 ( fieldname = 'ZAEHK' value = IV_WHERE-ZAEHK )
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = LV_VALUE ).

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











*"Test case #7  KONV redirect to CDS View
*select single kreli from konv into corresponding fields of konv
*  where kdatu > l_datum.











"Test case #8 KONV Select into Table
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 ( fieldname = 'KNUMV' value = IV_WHERE-KNUMV )
 ( fieldname = 'KSCHL' value = IV_WHERE-KSCHL )
 ( fieldname = 'KDATU' value = IV_WHERE-KDATU )
 ( fieldname = 'ZAEHK' value = IV_WHERE-ZAEHK )
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = LT_KONV ).

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











*"Test case #9 KONV Select into Fields
*select kschl kdatu from konv into (iv_where-kschl, iv_where-kdatu) where knumv EQ iv_where-knumv and kschl eq iv_where-kschl and kdatu eq iv_where-kdatu and zaehk eq iv_where-zaehk.
*endselect.
*










*"Test case #10 Select Star With Endselect
*select * from konv into ls_konv.
*endselect.











"Test case #11 Select with Whitelist Token Violation
SELECT kschl FROM PRCD_ELEMENTS INTO TABLE lt_konv GROUP BY kschl.











"Test case #12 Forbidden Tokens
SELECT kschl FROM PRCD_ELEMENTS INTO TABLE lt_konv WHERE kposn > 3.











"Test case #13 Forbidden Fields
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL207C0R8140) ).
  CLEAR LT_KONV.
  TYPES: BEGIN OF TYL207C0R711,
    KSCHL TYPE KONV-KSCHL,
    KDATU TYPE KONV-KDATU,
  END OF TYL207C0R711.
  DATA: LML207C0R6016 TYPE TYL207C0R711,
        LWL207C0R3900 LIKE LINE OF LT_KONV.
  LOOP AT ETL207C0R8140 REFERENCE INTO DATA(LDRL207C0R6298).
    LML207C0R6016-KSCHL = LDRL207C0R6298->KSCHL.
    LML207C0R6016-KDATU = LDRL207C0R6298->KDATU.
    MOVE-CORRESPONDING LML207C0R6016 TO LWL207C0R3900.
    APPEND LWL207C0R3900 TO LT_KONV.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











*"Test case #14 !Whitelist & Forbidden Fields
*select kschl kdatu from konv into corresponding fields of table lt_konv group by kschl kdatu.











"Test case #15 !Whitelist & Forbidden Tokens
SELECT kschl FROM PRCD_ELEMENTS INTO TABLE lt_konv WHERE kposn > 3 GROUP BY kschl.











*"Test case #16 Forbidden Fields & Forbidden Tokens
*select kdatu from konv into corresponding fields of table lt_konv where kposn > 3.











*"Test case #17 Select Star No Target/ No Where
*select * from konv.
*endselect.
*










*"Test case #18 Select Star No Target
*select * from konv where kposn = 3.
*endselect.











"Test case #19 Select Star No Where
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = LT_KONV ).

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #20 Select Single Star No Target/ No Where
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL300C0R1880) ).
KONV = ETL300C0R1880[ 1 ].
CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #21 Select Single Star No Target
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 ( fieldname = 'KPOSN' value = 3 )
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL313C0R7831) ).
KONV = ETL313C0R7831[ 1 ].
CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #22 Select Single Star No Where
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL326C0R8060) ).
LS_KONV = ETL326C0R8060[ 1 ] .
CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #23 Select * No Where
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL339C0R2187) ).
  CLEAR LT_KONV.
  TYPES: BEGIN OF TYL339C0R7616,
    KSCHL TYPE KONV-KSCHL,
    KRECH TYPE KONV-KRECH,
  END OF TYL339C0R7616.
  DATA: LML339C0R9840 TYPE TYL339C0R7616,
        LWL339C0R3711 LIKE LINE OF LT_KONV.
  LOOP AT ETL339C0R2187 REFERENCE INTO DATA(LDRL339C0R5679).
    LML339C0R9840-KSCHL = LDRL339C0R5679->KSCHL.
    LML339C0R9840-KRECH = LDRL339C0R5679->KRECH.
    LWL339C0R3711 = LML339C0R9840.
    APPEND LWL339C0R3711 TO LT_KONV.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #24 Select * Single No Where
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL352C0R9854) ).
  TYPES: BEGIN OF TYL352C0R9643,
    KSCHL TYPE KONV-KSCHL,
    KRECH TYPE KONV-KRECH,
  END OF TYL352C0R9643.
  DATA LML352C0R6354 TYPE TYL352C0R9643.
  LML352C0R6354-KSCHL = ETL352C0R9854[ 1 ]-KSCHL.
  LML352C0R6354-KRECH = ETL352C0R9854[ 1 ]-KRECH.
  LS_KONV = LML352C0R6354.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #25  Select * into Table KONV APPENDING
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL365C0R2775) ).
APPEND LINES OF ETL365C0R2775 TO LT_KONV.
CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











*"Test case #26  Select * Up To 1 Rows into Table KONV
*select * up to 1 rows from konv into table lt_konv .











"Test case #27  Forbidden Field & Select into Table KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL391C0R2275) ).
  CLEAR LT_KONV_CUST.
  TYPES: BEGIN OF TYL391C0R3379,
    KRECH TYPE KONV-KRECH,
  END OF TYL391C0R3379.
  DATA: LML391C0R9966 TYPE TYL391C0R3379,
        LWL391C0R3699 LIKE LINE OF LT_KONV_CUST.
  LOOP AT ETL391C0R2275 REFERENCE INTO DATA(LDRL391C0R5341).
    LML391C0R9966-KRECH = LDRL391C0R5341->KRECH.
    LWL391C0R3699 = LML391C0R9966.
    APPEND LWL391C0R3699 TO LT_KONV_CUST.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #28  Forbidden Field & Select into Table KONV APPENDING
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL404C0R1064) ).
  TYPES: BEGIN OF TYL404C0R4611,
    KRECH TYPE KONV-KRECH,
  END OF TYL404C0R4611.
  DATA: LML404C0R7877 TYPE TYL404C0R4611,
        LWL404C0R867 LIKE LINE OF LT_KONV.
  LOOP AT ETL404C0R1064 REFERENCE INTO DATA(LDRL404C0R6939).
    LML404C0R7877-KRECH = LDRL404C0R6939->KRECH.
    LWL404C0R867 = LML404C0R7877.
    APPEND LWL404C0R867 TO LT_KONV.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #29  Forbidden Field & Select into Table Cust APPENDING
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL417C0R3213) ).
  TYPES: BEGIN OF TYL417C0R3455,
    KRECH TYPE KONV-KRECH,
  END OF TYL417C0R3455.
  DATA: LML417C0R2166 TYPE TYL417C0R3455,
        LWL417C0R6661 LIKE LINE OF LT_KONV_CUST.
  LOOP AT ETL417C0R3213 REFERENCE INTO DATA(LDRL417C0R9563).
    LML417C0R2166-KRECH = LDRL417C0R9563->KRECH.
    LWL417C0R6661 = LML417C0R2166.
    APPEND LWL417C0R6661 TO LT_KONV_CUST.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #30  Forbidden Field & Select into Table KONV CORRESPONDING-FIELDS
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL430C0R4881) ).
  CLEAR LT_KONV.
  TYPES: BEGIN OF TYL430C0R9135,
    KRECH TYPE KONV-KRECH,
  END OF TYL430C0R9135.
  DATA: LML430C0R5741 TYPE TYL430C0R9135,
        LWL430C0R6549 LIKE LINE OF LT_KONV.
  LOOP AT ETL430C0R4881 REFERENCE INTO DATA(LDRL430C0R308).
    LML430C0R5741-KRECH = LDRL430C0R308->KRECH.
    MOVE-CORRESPONDING LML430C0R5741 TO LWL430C0R6549.
    APPEND LWL430C0R6549 TO LT_KONV.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #31  Forbidden Field & Select into Table Cust CORRESPONDING-FIELDS
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL669C0R3683) ).
  CLEAR LT_KONV_CUST.
  TYPES: BEGIN OF TYL669C0R852,
    KRECH TYPE KONV-KRECH,
  END OF TYL669C0R852.
  DATA: LML669C0R5988 TYPE TYL669C0R852,
        LWL669C0R6272 LIKE LINE OF LT_KONV_CUST.
  LOOP AT ETL669C0R3683 REFERENCE INTO DATA(LDRL669C0R7373).
    LML669C0R5988-KRECH = LDRL669C0R7373->KRECH.
    MOVE-CORRESPONDING LML669C0R5988 TO LWL669C0R6272.
    APPEND LWL669C0R6272 TO LT_KONV_CUST.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #32  Forbidden Field & Select into Table KONV APPENDING CORRESPONDING-FIELDS
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL682C0R2253) ).
  TYPES: BEGIN OF TYL682C0R6795,
    KRECH TYPE KONV-KRECH,
  END OF TYL682C0R6795.
  DATA: LML682C0R794 TYPE TYL682C0R6795,
        LWL682C0R4855 LIKE LINE OF LT_KONV.
  LOOP AT ETL682C0R2253 REFERENCE INTO DATA(LDRL682C0R633).
    LML682C0R794-KRECH = LDRL682C0R633->KRECH.
    MOVE-CORRESPONDING LML682C0R794 TO LWL682C0R4855.
    APPEND LWL682C0R4855 TO LT_KONV.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #33  Forbidden Field & Select into Table Cust APPENDING CORRESPONDING-FIELDS
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL695C0R8136) ).
  TYPES: BEGIN OF TYL695C0R6182,
    KRECH TYPE KONV-KRECH,
  END OF TYL695C0R6182.
  DATA: LML695C0R1205 TYPE TYL695C0R6182,
        LWL695C0R8959 LIKE LINE OF LT_KONV_CUST.
  LOOP AT ETL695C0R8136 REFERENCE INTO DATA(LDRL695C0R8153).
    LML695C0R1205-KRECH = LDRL695C0R8153->KRECH.
    MOVE-CORRESPONDING LML695C0R1205 TO LWL695C0R8959.
    APPEND LWL695C0R8959 TO LT_KONV_CUST.
  ENDLOOP.

CATCH CX_PRC_RESULT .
  SY-SUBRC = 4.
ENDTRY.











"Test case #34  Select Single into Struc KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL708C0R8253) ).
  TYPES: BEGIN OF TYL708C0R213,
    KRECH TYPE KONV-KRECH,
  END OF TYL708C0R213.
  DATA LML708C0R6252 TYPE TYL708C0R213.
  LML708C0R6252-KRECH = ETL708C0R8253[ 1 ]-KRECH.
  LS_KONV = LML708C0R6252.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #35  Select Single into Struc Cust
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL721C0R5188) ).
  TYPES: BEGIN OF TYL721C0R9111,
    KRECH TYPE KONV-KRECH,
  END OF TYL721C0R9111.
  DATA LML721C0R6105 TYPE TYL721C0R9111.
  LML721C0R6105-KRECH = ETL721C0R5188[ 1 ]-KRECH.
  LS_KONV_CUST = LML721C0R6105.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #36  Select * Single into Struc KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL734C0R3625) ).
LS_KONV = ETL734C0R3625[ 1 ] .
CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #37  Select Single into Struc KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL747C0R3972) ).
  TYPES: BEGIN OF TYL747C0R2146,
    KRECH TYPE KONV-KRECH,
  END OF TYL747C0R2146.
  DATA LML747C0R3933 TYPE TYL747C0R2146.
  LML747C0R3933-KRECH = ETL747C0R3972[ 1 ]-KRECH.
  MOVE-CORRESPONDING LML747C0R3933 TO LS_KONV.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #38  Select Single into Struc Cust
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL760C0R665) ).
  TYPES: BEGIN OF TYL760C0R3630,
    KRECH TYPE KONV-KRECH,
  END OF TYL760C0R3630.
  DATA LML760C0R4818 TYPE TYL760C0R3630.
  LML760C0R4818-KRECH = ETL760C0R665[ 1 ]-KRECH.
  MOVE-CORRESPONDING LML760C0R4818 TO LS_KONV_CUST.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #39  Select * Single into Struc KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL773C0R9315) ).
LS_KONV = ETL773C0R9315[ 1 ] .
CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #40  Select * Single into Struc Cust
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL786C0R3186) ).
  MOVE-CORRESPONDING ETL786C0R3186[ 1 ] TO LS_KONV_CUST.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #41  Select Single into Struc KONV
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL799C0R4278) ).
  TYPES: BEGIN OF TYL799C0R6279,
    KRECH TYPE KONV-KRECH,
  END OF TYL799C0R6279.
  DATA LML799C0R2108 TYPE TYL799C0R6279.
  LML799C0R2108-KRECH = ETL799C0R4278[ 1 ]-KRECH.
  LS_KONV-KRECH = LML799C0R2108.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #42  Answer to the Ultimate Question of Life, the Universe, and Everything
TRY.

CL_PRC_RESULT_FACTORY=>GET_INSTANCE( )->GET_PRC_RESULT( )->GET_PRICE_ELEMENT_DB(
  EXPORTING IT_SELECTION_ATTRIBUTE = VALUE #(
 )
  IMPORTING ET_PRC_ELEMENT_CLASSIC_FORMAT = DATA(ETL812C0R1259) ).
  TYPES: BEGIN OF TYL812C0R4399,
    KRECH TYPE KONV-KRECH,
  END OF TYL812C0R4399.
  DATA LML812C0R3724 TYPE TYL812C0R4399.
  LML812C0R3724-KRECH = ETL812C0R1259[ 1 ]-KRECH.
  LV_KONV_KRECH = LML812C0R3724.

CATCH CX_PRC_RESULT CX_SY_ITAB_LINE_NOT_FOUND .
  SY-SUBRC = 4.
ENDTRY.











"Test case #43  No quickfix possible at all because "for update" -> CDS View select would not be allowed
SELECT SINGLE FOR UPDATE krech FROM konv INTO lv_konv_krech.











"Test case #44  CDS View
SELECT SINGLE krech, kschl FROM konv INTO ( @DATA(l_krech), @DATA(l_kschl) ) WHERE kschl < '1'.
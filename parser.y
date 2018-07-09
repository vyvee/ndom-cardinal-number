/* Ndom numbers
 * Range: 1-143 (i.e., 1-355 base-6), integers.
 * References:
 * - http://www.sf.airnet.ne.jp/ts/language/number/ndom.html
 * - https://en.wikipedia.org/wiki/Ndom_language
 * - http://www.ioling.org/problems/2007/i4/
 */
%output "parser.c"
%defines "parser.h"
%define api.pure

/* The grammar is unambiguous, but requires LR(2) to parse properly.
 * It can be rewritten so that LALR(1) would suffice, but the grammar will
 * be less human readable.
 */
%glr-parser
/* The expected shift-reduce conflict happens here:
 *   TONDOR . ABO
 * The parser does not know if it should reduce to 'place_one' or shift to
 * expect ABO MER etc.
 */
%expect 1

%lex-param   { yyscan_t scanner_data }
%parse-param { yyscan_t scanner_data }
%parse-param { int *p_value }

%{
#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T
typedef void* yyscan_t;
#endif
int yylex(int *, yyscan_t);
void yyerror(yyscan_t, int *, ...);
%}

%token SAS THEF ITHIN THONITH MEREGH MER TONDOR NIF
%token ABO AN

%%
input:
    number { *p_value = $1; }
  ;

number:
    place_zero
  | place_one
  | place_one ABO place_zero { $$ = $1 + $3; }
  | place_two
  | place_two ABO place_zero { $$ = $1 + $3; }
  | place_two ABO place_one { $$ = $1 + $3; }
  | place_two ABO place_one ABO place_zero { $$ = $1 + $3 + $5; }
  ;

place_zero:
    SAS { $$ = 1; }
  | THEF { $$ = 2; }
  | ITHIN { $$ = 3; }
  | THONITH { $$ = 4; }
  | MEREGH { $$ = 5; }
  ;

place_one:
    place_one_lower
  | place_one_upper
  | place_one_upper ABO place_one_lower { $$ = $1 + $3; }
  ;

place_one_upper:
    TONDOR { $$ = 6*3; }
  ;

place_one_lower:
    MER { $$ = 6; }
  | MER AN THEF { $$ = 6*2; }
  ;

place_two:
    NIF { $$ = 6*6; }
  | NIF THEF { $$ = 6*6*2; }
  | NIF ITHIN { $$ = 6*6*3; }
  ;
%%
#include <ctype.h>

#include "scanner.h"
#include "ndom.h"

void yyerror(yyscan_t scanner, int *p_value, ...)
{
  (void) scanner;
  (void) p_value;
}

int ndom_to_int(const char *str)
{
  yyscan_t scanner_info;
  if (yylex_init(&scanner_info)) {
    yylex_destroy(scanner_info);
    return -1;
  }

  YY_BUFFER_STATE buffer_state = yy_scan_string(str, scanner_info);
  yy_switch_to_buffer(buffer_state, scanner_info);

  int value;
  if (yyparse(scanner_info, &value)) {
    yy_delete_buffer(buffer_state, scanner_info);
    yylex_destroy(scanner_info);
    return -1;
  }

  yy_delete_buffer(buffer_state, scanner_info);
  yylex_destroy(scanner_info);
  
  return value;
}

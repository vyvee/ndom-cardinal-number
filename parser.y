%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *); 
%}
/* Ndom numbers, 1-143 (i.e., 1-355 base-6), integers.
 * References:
 * - http://www.sf.airnet.ne.jp/ts/language/number/ndom.html
 * - https://en.wikipedia.org/wiki/Ndom_language
 * - http://www.ioling.org/problems/2007/i4/
 */

/* The grammar is unambiguous, but requires LR(2) to parse properly.
 * It can be rewritten so that LALR(1) would suffice, but the grammar will
 * be less human readable. Choose to use GLR parser instead.
 */
%glr-parser
/* The expected shift-reduce conflict happens here:
 *   TONDOR . ABO
 * The parser does not know if it should reduce to 'place_one' or shift to
 * expect ABO MER etc.
 */
%expect 1

/*%output "parser.c"*/

%token SAS THEF ITHIN THONITH MEREGH MER TONDOR NIF
%token ABO AN
%token EOL

%%
input:
    input line
  | /* empty */
  ;

line:
    EOL
  | number EOL  { printf("%d\n", $1); }
  ;

number:
    place_zero { $$ = $1; }
  | place_one { $$ = $1; }
  | place_one ABO place_zero { $$ = $1 + $3; }
  | place_two { $$ = $1; }
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
    TONDOR { $$ = 6*3; }
  | TONDOR ABO MER { $$ = 6*3 + 6; }
  | TONDOR ABO MER AN THEF { $$ = 6*3 + 6*2; }
  ;

place_two:
    NIF { $$ = 6*6; }
  | NIF THEF { $$ = 6*6*2; }
  | NIF ITHIN { $$ = 6*6*3; }
  ;
%%
#include <ctype.h>

void yyerror(const char *s)
{
  printf("Error: %s\n", s);
}

/*
void ndom_parse(const char *str)
{
  YY_BUFFER_STATE bp;
  bp = yy_scan_string(str);
  yy_switch_to_buffer(bp);
  yyparse();
}
*/

int main(void)
{
  // ndom_parse("nif thef");
  yyparse();
  return 0;
}

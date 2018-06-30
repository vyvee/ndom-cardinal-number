#include <stdio.h>

#include "scanner.h"
#include "parser.h"

int yyerror(yyscan_t scanner, const char *msg)
{
  return 0;
}

int ndom_parse(void)
{
  yyscan_t scanner_info;
  if (yylex_init(&scanner_info)) {
    return -1;
  }
  yyparse(scanner_info);
  yylex_destroy(scanner_info);
  return 0;
}

int main(void)
{
  // ndom_parse("nif thef");
  ndom_parse();

  return 0;
}

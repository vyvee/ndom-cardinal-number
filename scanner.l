%option outfile="scanner.c" header-file="scanner.h"
%option reentrant
%option noinput nounput noyywrap
%option case-insensitive

%{
#include "parser.h"
%}

%%
sas     { return SAS; }
thef    { return THEF; }
ithin   { return ITHIN; }
thonith { return THONITH; }
meregh  { return MEREGH; }
mer     { return MER; }
tondor  { return TONDOR; }
nif     { return NIF; }
abo     { return ABO; }
an      { return AN; }
[\n]    { return EOL; }
[ \t]+  {}   
.       { return yytext[0]; }
%%

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include "ndom.h"

int main(void)
{
  char ndom_string[NDOM_CHARS_MAX+2];
  int value;

  if (ndom_test() < 0) {
    printf("Internal Error.");
    exit(1);
  }

  for (;;) {

    printf("Please enter an integer or a Ndom cardinal number: ");
    if (!fgets(ndom_string, NDOM_CHARS_MAX+2, stdin)) {
      break;
    }

    if (isdigit(ndom_string[0])) {
      value = atoi(ndom_string);
      if (int_to_ndom(value, ndom_string)) {
	printf("  => %s\n", ndom_string);
      }
      else {
	puts("  [Error]");
      }
    }
    else {
      value = ndom_to_int(ndom_string);
      if (value > 0) {
	printf("  => %d\n", value);
      }
      else {
	puts("  [Error]");
      }
    }
  }

  return 0;
}

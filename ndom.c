#include <stdio.h>

#include "ndom.h"

int main(void)
{
  char ndom_string[80];
  int value;

  for (;;) {
    printf("Enter an Ndom cardinal number: ");
    if (!fgets(ndom_string, 80, stdin)) {
      break;
    }
    value = ndom_parse(ndom_string);
    if (value < 0) {
      puts("[Invalid]");
    }
    else {
      printf("= %d\n", value);
    }
  }

  return 0;
}

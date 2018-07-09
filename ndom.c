#include "ndom.h"

#include <string.h>

char *int_to_ndom(int value, char *str)
{
  if (value < 1 || value > 143) {
    return NULL;
  }

  int pos = 0;

  if (value >= 6*6*3) {
    memcpy(str+pos, "nif ithin", 9);
    pos += 9;
    value -= 6*6*3;
  }
  else if (value >= 6*6*2) {
    memcpy(str+pos, "nif thef", 8);
    pos += 8;
    value -= 6*6*2;
  }
  else if (value >= 6*6) {
    memcpy(str+pos, "nif", 3);
    pos += 3;
    value -= 6*6;
  }

  if (value >= 6*3) {
    if (pos) {
      memcpy(str+pos, " abo ", 5);
      pos += 5;
    }
    memcpy(str+pos, "tondor", 6);
    pos += 6;
    value -= 6*3;
  }

  if (value >= 6*2) {
    if (pos) {
      memcpy(str+pos, " abo ", 5);
      pos += 5;
    }
    memcpy(str+pos, "mer an thef", 11);
    pos += 11;
    value -= 6*2;
  }
  else if (value >= 6) {
    if (pos) {
      memcpy(str+pos, " abo ", 5);
      pos += 5;
    }
    memcpy(str+pos, "mer", 3);
    pos += 3;
    value -= 6;
  }

  if (value > 0) {
    if (pos) {
      memcpy(str+pos, " abo ", 5);
      pos += 5;
    }
    switch (value) {
    case 1:
      memcpy(str+pos, "sas", 3);
      pos += 3;
      break;
    case 2:
      memcpy(str+pos, "thef", 4);
      pos += 4;
      break;
    case 3:
      memcpy(str+pos, "ithin", 5);
      pos += 5;
      break;
    case 4:
      memcpy(str+pos, "thonith", 7);
      pos += 7;
      break;
    case 5:
      memcpy(str+pos, "meregh", 6);
      pos += 6;
      break;
    }
  }

  str[pos] = '\0';

  return str;
}

int ndom_test(void)
{
  char ndom_string[NDOM_CHARS_MAX+1];

  for (int i=1; i<=143; i++) {
    if (!int_to_ndom(i, ndom_string)) {
      return -1;
    }
    if (ndom_to_int(ndom_string) < 0) {
      return -1;
    }
  }
  return 0;
}

#include <string.h>

#include "ndom.h"

#define COPY_STRING(d, p, s) \
  { char *_s = s; while (*_s) *((d)+(p)++) = *_s++; }

char *int_to_ndom(int value, char *str)
{
  if (value < 1 || value > 143) {
    return NULL;
  }

  int pos = 0;

  if (value >= 6*6*3) {
    COPY_STRING(str, pos, "nif ithin");
    value -= 6*6*3;
  }
  else if (value >= 6*6*2) {
    COPY_STRING(str, pos, "nif thef");
    value -= 6*6*2;
  }
  else if (value >= 6*6) {
    COPY_STRING(str, pos, "nif");
    value -= 6*6;
  }

  if (value >= 6*3) {
    if (pos)
      COPY_STRING(str, pos, " abo ");
    COPY_STRING(str, pos, "tondor");
    value -= 6*3;
  }

  if (value >= 6*2) {
    if (pos)
      COPY_STRING(str, pos, " abo ");
    COPY_STRING(str, pos, "mer an thef");
    value -= 6*2;
  }
  else if (value >= 6) {
    if (pos)
      COPY_STRING(str, pos, " abo ");
    COPY_STRING(str, pos, "mer");
    value -= 6;
  }

  if (value > 0) {
    if (pos)
      COPY_STRING(str, pos, " abo ");
    switch (value) {
    case 1:
      COPY_STRING(str, pos, "sas");
      break;
    case 2:
      COPY_STRING(str, pos, "thef");
      break;
    case 3:
      COPY_STRING(str, pos, "ithin");
      break;
    case 4:
      COPY_STRING(str, pos, "thonith");
      break;
    case 5:
      COPY_STRING(str, pos, "meregh");
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

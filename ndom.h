#ifndef NDOM_H_
#define NDOM_H_

#define NDOM_CHARS_MAX 48

char *int_to_ndom(int value, char *str);
int ndom_to_int(const char *str);

int ndom_test(void);

#endif

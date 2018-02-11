#include <stdlib.h>
#include "fcgi_stdio.h"

int main () {
    int count = 0;

    while(FCGI_Accept() >= 0) {
        printf("Content-type: text/html\r\n"
               "\r\n"
               "Request number %d on host <i>%s</i> at <i>%s</i>\n",
               ++count, getenv("SERVER_NAME"), getenv("REQUEST_URI"));
    }

    return 0;
}

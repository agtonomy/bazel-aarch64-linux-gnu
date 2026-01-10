#include <stdio.h>

int main(void) {
    printf("Hello from C!\n");
    printf("Compiler: GCC %d.%d.%d\n", __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__);
#if defined(__aarch64__)
    printf("Architecture: aarch64\n");
#elif defined(__x86_64__)
    printf("Architecture: x86_64\n");
#else
    printf("Architecture: unknown\n");
#endif
    return 0;
}

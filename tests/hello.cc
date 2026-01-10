#include <iostream>
#include <string>
#include <vector>

int main() {
    std::cout << "Hello from C++!" << std::endl;
    std::cout << "Compiler: GCC " << __GNUC__ << "." << __GNUC_MINOR__ << "." << __GNUC_PATCHLEVEL__ << std::endl;

#if defined(__aarch64__)
    std::cout << "Architecture: aarch64" << std::endl;
#elif defined(__x86_64__)
    std::cout << "Architecture: x86_64" << std::endl;
#else
    std::cout << "Architecture: unknown" << std::endl;
#endif

    // Test STL
    std::vector<int> v = {1, 2, 3};
    std::cout << "Vector size: " << v.size() << std::endl;

    return 0;
}

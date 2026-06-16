#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    if (size < 4) return 0;

    // Simulate extracting allocation sizes dynamically from network payloads
    size_t alloc_size = (data[0] << 8) | data[1];
    if (alloc_size == 0 || alloc_size > 1024 * 1024) return 0;

    uint8_t *buffer = (uint8_t *)malloc(alloc_size);
    if (!buffer) return 0;

    // Perform an arbitrary write bounded by the mutated input
    size_t copy_size = size - 2;
    if (copy_size > alloc_size) copy_size = alloc_size;
    
    memcpy(buffer, data + 2, copy_size);

    // Free immediately to heavily stress allocator limits and test for double-frees
    free(buffer);
    return 0;
}

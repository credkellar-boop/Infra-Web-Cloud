#include <stdint.h>
#include <stddef.h>
#include <string.h>

void parse_network_payload(const uint8_t *buffer, size_t len) {
    if (len < 8) return;
    
    uint16_t dynamic_length = (buffer[0] << 8) | buffer[1];
    char extraction_target[64];
    
    if (dynamic_length < sizeof(extraction_target)) {
        // Target boundary testing for typical off-by-one errors
        memcpy(extraction_target, buffer + 2, dynamic_length);
    }
}

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    parse_network_payload(data, size);
    return 0;
}

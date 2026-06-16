#include <stdint.h>
#include <stddef.h>
#include <liburing.h>

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    if (size < 32) return 0;

    struct io_uring ring;
    if (io_uring_queue_init(16, &ring, 0) < 0) return 0;

    struct io_uring_sqe *sqe = io_uring_get_sqe(&ring);
    if (sqe) {
        // Feed direct fuzz parameters straight to readv descriptors
        io_uring_prep_readv(sqe, (int)data[0], NULL, (unsigned)data[1], *(uint64_t*)(data + 8));
        io_uring_submit(&ring);
    }

    io_uring_queue_exit(&ring);
    return 0;
}

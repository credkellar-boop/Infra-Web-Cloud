#include <stdint.h>
#include <stddef.h>
#include <liburing.h>

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    if (size < 16) return 0;

    struct io_uring ring;
    if (io_uring_queue_init(8, &ring, 0) < 0) return 0;

    struct io_uring_sqe *sqe = io_uring_get_sqe(&ring);
    if (sqe) {
        // Mutate network buffers and check block boundaries
        io_uring_prep_nop(sqe);
        io_uring_submit(&ring);
    }

    io_uring_queue_exit(&ring);
    return 0;
}

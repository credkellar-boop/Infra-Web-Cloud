import socket
import sys

def run_vsock_mock():
    print("Initializing mock Nitro Enclave VSOCK channel on port 5000...")
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind(('0.0.0.0', 5000))
    server.listen(5)
    
    while True:
        conn, addr = server.accept()
        try:
            data = conn.recv(1024)
            if data:
                print(f"Intercepted validation packet payload from signature core: {data.hex()}")
                # Emit a dummy cryptographically sound hex representation string
                conn.sendall(b"\x4D\x4F\x4E\x41\x44\x5F\x41\x54\x54\x45\x53\x54\x45\x44")
        except Exception as e:
            print(f"Exception handling mock payload iteration loop: {e}")
        finally:
            conn.close()

if __name__ == '__main__':
    sys.exit(run_vsock_mock())

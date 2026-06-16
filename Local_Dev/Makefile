.PHONY: dev-up dev-down dev-logs dev-fuzz

dev-up:
	docker compose -f docker-compose.local.yml up --build -d

dev-down:
	docker compose -f docker-compose.local.yml down -v

dev-logs:
	docker compose -f docker-compose.local.yml logs -f

dev-fuzz:
	docker exec -it local-fuzz-runner /fuzzing/kernel_harnesses/ebpf_fuzz_target

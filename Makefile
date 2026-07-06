# Makefile for Kinnector Portal
# Serves as a unified orchestrator to build components in the repository.

.PHONY: all help core agent cli desktop config warden clean

# Colors for pretty terminal output
YELLOW := \033[1;33m
GREEN  := \033[1;32m
BLUE   := \033[1;34m
RESET  := \033[0m

help:
	@echo -e "$(BLUE)Kinnector Portal Build Orchestrator$(RESET)"
	@echo -e "Usage: make [target]"
	@echo -e ""
	@echo -e "Available targets:"
	@echo -e "  $(YELLOW)all$(RESET)      - Build all compileable components (core, agent, cli, desktop, config, warden)"
	@echo -e "  $(YELLOW)core$(RESET)     - Build low-level telemetry engine (CMake/C++)"
	@echo -e "  $(YELLOW)agent$(RESET)    - Build endpoint agent daemon (Cargo/Rust)"
	@echo -e "  $(YELLOW)cli$(RESET)      - Build terminal client interface (Cargo/Rust)"
	@echo -e "  $(YELLOW)desktop$(RESET)  - Build Svelte/Vite fleet administration dashboard (npm/Node)"
	@echo -e "  $(YELLOW)config$(RESET)   - Build cryptographic rule validation library (Cargo/Rust)"
	@echo -e "  $(YELLOW)warden$(RESET)   - Build central warden fleet receiver (Cargo/Rust)"
	@echo -e "  $(YELLOW)clean$(RESET)    - Clean build files across all components"

all: core agent cli desktop config warden
	@echo -e "$(GREEN)✔ All Kinnector components built successfully!$(RESET)"

core:
	@echo -e "$(BLUE)Building kinnector-core...$(RESET)"
	@if [ -d "src/kinnector-core" ]; then \
		mkdir -p src/kinnector-core/build && \
		cd src/kinnector-core/build && \
		cmake -DCMAKE_BUILD_TYPE=Release .. && \
		make -j$$(nproc); \
	else \
		echo -e "$(YELLOW)Warning: src/kinnector-core directory not found. Did you clone with submodules?$(RESET)"; \
	fi

agent:
	@echo -e "$(BLUE)Building kinnector-agent...$(RESET)"
	@if [ -d "src/kinnector-agent" ]; then \
		cd src/kinnector-agent && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: src/kinnector-agent directory not found. Did you clone with submodules?$(RESET)"; \
	fi

cli:
	@echo -e "$(BLUE)Building kinnector-cli...$(RESET)"
	@if [ -d "src/kinnector-cli" ]; then \
		cd src/kinnector-cli && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: src/kinnector-cli directory not found. Did you clone with submodules?$(RESET)"; \
	fi

desktop:
	@echo -e "$(BLUE)Building kinnector-desktop...$(RESET)"
	@if [ -d "src/kinnector-desktop" ]; then \
		cd src/kinnector-desktop && npm install && npm run build; \
	else \
		echo -e "$(YELLOW)Warning: src/kinnector-desktop directory not found. Did you clone with submodules?$(RESET)"; \
	fi

config:
	@echo -e "$(BLUE)Building kinnector-config...$(RESET)"
	@if [ -d "src/kinnector-config" ]; then \
		cd src/kinnector-config && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: src/kinnector-config directory not found. Did you clone with submodules?$(RESET)"; \
	fi

warden:
	@echo -e "$(BLUE)Building kinnector-warden...$(RESET)"
	@if [ -d "src/kinnector-warden" ]; then \
		cd src/kinnector-warden && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: src/kinnector-warden directory not found. Did you clone with submodules?$(RESET)"; \
	fi

clean:
	@echo -e "$(BLUE)Cleaning build artifacts...$(RESET)"
	@if [ -d "src/kinnector-core/build" ]; then rm -rf src/kinnector-core/build; fi
	@if [ -d "src/kinnector-agent" ]; then cd src/kinnector-agent && cargo clean; fi
	@if [ -d "src/kinnector-cli" ]; then cd src/kinnector-cli && cargo clean; fi
	@if [ -d "src/kinnector-desktop/dist" ]; then rm -rf src/kinnector-desktop/dist src/kinnector-desktop/node_modules; fi
	@if [ -d "src/kinnector-config" ]; then cd src/kinnector-config && cargo clean; fi
	@if [ -d "src/kinnector-warden" ]; then cd src/kinnector-warden && cargo clean; fi
	@echo -e "$(GREEN)✔ All build artifacts cleaned.$(RESET)"

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
	@if [ -d "kinnector-core" ]; then \
		mkdir -p kinnector-core/build && \
		cd kinnector-core/build && \
		cmake -DCMAKE_BUILD_TYPE=Release .. && \
		make -j$$(nproc); \
	else \
		echo -e "$(YELLOW)Warning: kinnector-core directory not found. Did you clone with submodules?$(RESET)"; \
	fi

agent:
	@echo -e "$(BLUE)Building kinnector-agent...$(RESET)"
	@if [ -d "kinnector-agent" ]; then \
		cd kinnector-agent && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: kinnector-agent directory not found. Did you clone with submodules?$(RESET)"; \
	fi

cli:
	@echo -e "$(BLUE)Building kinnector-cli...$(RESET)"
	@if [ -d "kinnector-cli" ]; then \
		cd kinnector-cli && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: kinnector-cli directory not found. Did you clone with submodules?$(RESET)"; \
	fi

desktop:
	@echo -e "$(BLUE)Building kinnector-desktop...$(RESET)"
	@if [ -d "kinnector-desktop" ]; then \
		cd kinnector-desktop && npm install && npm run build; \
	else \
		echo -e "$(YELLOW)Warning: kinnector-desktop directory not found. Did you clone with submodules?$(RESET)"; \
	fi

config:
	@echo -e "$(BLUE)Building kinnector-config...$(RESET)"
	@if [ -d "kinnector-config" ]; then \
		cd kinnector-config && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: kinnector-config directory not found. Did you clone with submodules?$(RESET)"; \
	fi

warden:
	@echo -e "$(BLUE)Building kinnector-warden...$(RESET)"
	@if [ -d "kinnector-warden" ]; then \
		cd kinnector-warden && cargo build --release; \
	else \
		echo -e "$(YELLOW)Warning: kinnector-warden directory not found. Did you clone with submodules?$(RESET)"; \
	fi

clean:
	@echo -e "$(BLUE)Cleaning build artifacts...$(RESET)"
	@if [ -d "kinnector-core/build" ]; then rm -rf kinnector-core/build; fi
	@if [ -d "kinnector-agent" ]; then cd kinnector-agent && cargo clean; fi
	@if [ -d "kinnector-cli" ]; then cd kinnector-cli && cargo clean; fi
	@if [ -d "kinnector-desktop/dist" ]; then rm -rf kinnector-desktop/dist kinnector-desktop/node_modules; fi
	@if [ -d "kinnector-config" ]; then cd kinnector-config && cargo clean; fi
	@if [ -d "kinnector-warden" ]; then cd kinnector-warden && cargo clean; fi
	@echo -e "$(GREEN)✔ All build artifacts cleaned.$(RESET)"

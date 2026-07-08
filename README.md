# Kinnector: Unified Endpoint & Server Security

Kinnector is an open-source, high-performance security and telemetry platform designed to monitor hosts, enforce behavioral security policies, and protect distributed server fleets.

---

## Why Kinnector exists

Traditional security solutions focus primarily on static signature scanning, failing to intercept zero-day exploits, package manager supply chain attacks, or fileless memory execution. Furthermore, enterprise EDR solutions are closed-source, heavy, and rely on reactive cloud analysis that allows malicious payloads to run before containment occurs.

Kinnector solves this by providing modular runtime protection. It captures OS-level events directly via native kernel telemetry (BPF LSM, ETW, EndpointSecurity) and evaluates behavioral rules in real-time, executing synchronous containment at the host and application level.

---

## The Kinnector Ecosystem

This repository is the central hub, aggregating the ecosystem's public components as Git submodules under the `src/` directory.

### 🧭 Product Navigation

#### 1. Endpoint & Desktop Stack
Protects local client workstations (Windows, macOS, Linux) by gathering telemetry, running rules, and executing containment actions.
* **[kinnector-core](src/kinnector-core)**: Low-level C++ telemetry engine extracting events from ETW, eBPF, and EndpointSecurity.
* **[kinnector-agent](src/kinnector-agent)**: Central Rust daemon evaluating behavioral rules against telemetry.
* **[kinnector-desktop](src/kinnector-desktop)**: Desktop administration dashboard built with Svelte 5 and Tauri.
* **[kinnector-cli](src/kinnector-cli)**: Command-line utility for local status queries and rule management.
* **[kinnector-installer](src/kinnector-installer)**: Packaging configurations (DEB, RPM, MSI) for endpoint deployment.
* **[kinnector-jvmti](src/kinnector-jvmti)**: Native JVMTI agent for Java runtime telemetry.

#### 2. Warden Fleet Central
Coordinates remote policies and aggregates telemetry alerts from server workloads and containers.
* **[kinnector-warden](src/kinnector-warden)** (aka **[warden](src/warden)**): The server-side coordinator and alerts receiver.
* **[kinnector-docker](src/kinnector-docker)**: Dockerfiles and sidecar configurations for container deployments.
* **[kinnector-collect](src/kinnector-collect)**: Audit-only deployment tools for baseline configuration analysis.

#### 3. WordPress Security
* **[kinnector-wordpress](src/kinnector-wordpress)** (aka **[wpwarden](src/wpwarden)**): Web application security plugin that filters queries and parameters before WordPress processes them.

#### 4. Shared Core Components
* **[kinnector-config](src/kinnector-config)**: Configuration library for parsing and validating cryptographically signed rules.
* **[kinnector-protect-community](src/kinnector-protect-community)**: Public registry of threat indicators and security rules.
* **[kinnector-design](src/kinnector-design)**: Visual style guides, assets, and design system definitions.
* **[kinnector-docs](src/kinnector-docs)**: Platform architecture books and developer specifications.

---

## Workspace Orchestration

A root-level `Makefile` builds or configures individual components from the root of the workspace:

```bash
# View available build options
make help

# Build compilation-required components (core, agent, cli, desktop, config, warden)
make all

# Build individual submodules
make core      # Build C++ telemetry engine
make agent     # Build Rust agent daemon
make cli       # Build Rust CLI tool
make desktop   # Build Tauri/Svelte UI dashboard
make warden    # Build Rust fleet server
```

---

## Getting Started

Clone the repository and initialize all submodules in one command:

```bash
git clone --recursive https://github.com/kinnector/kinnector.git
```

To fetch submodules in an existing clone:

```bash
git submodule update --init --recursive
```

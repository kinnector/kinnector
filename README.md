<p align="center">
  <img src="assets/hero.svg" alt="**kinnector** Unified Threat Intelligence" width="100%" />
</p>

<p align="center">
  <a href="https://github.com/kinnector/kinnector/actions"><img src="https://img.shields.io/github/actions/workflow/status/kinnector/kinnector-core/ci.yml?branch=main&style=flat-square&color=34d399" alt="CI Status" /></a>
  <a href="https://github.com/kinnector/kinnector/blob/main/LICENSE"><img src="https://img.shields.io/github/license/kinnector/kinnector-core?style=flat-square&color=8b5cf6" alt="License" /></a>
  <a href="https://github.com/kinnector/kinnector/submodules"><img src="https://img.shields.io/badge/submodules-16%20active-3b82f6?style=flat-square" alt="Submodules" /></a>
</p>

---

**kinnector** is a modern, high-performance security and telemetry platform designed to monitor systems, enforce heuristic security policies, and manage distributed fleets of agents. By capturing low-level system calls, kernel-level events, and application runtimes, **kinnector** provides real-time threat intelligence and active containment capabilities.

This portal repository serves as the central hub, consolidating all public components of the **kinnector** ecosystem as Git submodules located under the `src/` directory.

---

## 🧭 Product Navigation

Select the **kinnector** product line that matches your deployment and security requirements:

<table align="center" border="0" cellpadding="10" cellspacing="0" width="100%">
  <tr>
    <td align="center" valign="top" width="33%">
      <a href="#-endpoint--desktop-stack">
        <img src="assets/desktop.svg" alt="**kinnector** Desktop" width="100%" style="border-radius: 8px; border: 1px solid #10b981;" />
      </a>
      <br />
      <h3>Endpoint &amp; Desktop</h3>
      <p>Local event telemetry, Rust agent daemon, installers, and admin command line tools.</p>
      <a href="#-endpoint--desktop-stack"><b>Explore Desktop Stack &rarr;</b></a>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="#-warden-fleet-central">
        <img src="assets/warden.svg" alt="**kinnector** Warden" width="100%" style="border-radius: 8px; border: 1px solid #8b5cf6;" />
      </a>
      <br />
      <h3>Warden Central Fleet</h3>
      <p>Server-side coordinator, telemetry aggregator, and container-ready sidecar setups.</p>
      <a href="#-warden-fleet-central"><b>Explore Warden Stack &rarr;</b></a>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="#-wordpress-runtime-security">
        <img src="assets/wordpress.svg" alt="WordPress Security" width="100%" style="border-radius: 8px; border: 1px solid #f59e0b;" />
      </a>
      <br />
      <h3>WordPress Protector</h3>
      <p>Active web runtime protection, malicious injection blocks, and admin shield plugin.</p>
      <a href="#-wordpress-runtime-security"><b>Explore WordPress Stack &rarr;</b></a>
    </td>
  </tr>
</table>

---

## 💻 Endpoint & Desktop Stack

For local endpoint protection, threat intelligence gathering, and containment rules execution directly on client machines (Windows, macOS, Linux).

```
[System Events] ──> [src/kinnector-core] ──> [src/kinnector-agent (Rust)] ──> [Containment Action]
                                                      │
                                                      ├──> [src/kinnector-desktop (Svelte)]
                                                      └──> [src/kinnector-cli]
```

### Primary Repositories & Submodules
* **[kinnector-core](src/kinnector-core)**: Low-level event processing engine extracting telemetry from ETW (Windows), eBPF (Linux), and EndpointSecurity (macOS).
* **[kinnector-agent](src/kinnector-agent)**: The central daemon written in Rust that evaluates behavioral rules against telemetry streams.
* **[kinnector-desktop](src/kinnector-desktop)**: High-performance administration dashboard built with Svelte 5, Vite, and Tailwind CSS.
* **[kinnector-cli](src/kinnector-cli)**: Fast command line interface for local rule configuration and status checking.
* **[kinnector-installer](src/kinnector-installer)**: Scripts and packaging assets (DEB, RPM, MSI) for cross-platform agent deployments.
* **[kinnector-jvmti](src/kinnector-jvmti)**: Java Virtual Machine Tool Interface agent for application-level monitoring.

---

## 🗼 Warden Fleet Central

For server-side operators managing large groups of distributed endpoints, coordinating remote rules, and querying real-time telemetry.

```
[kinnector-agent] ──(HTTPS/gRPC)──> [src/kinnector-warden (Warden Server)]
                                                  │
                                                  ├──> [src/kinnector-docker]
                                                  └──> [src/kinnector-collect]
```

### Primary Repositories & Submodules
* **[kinnector-warden](src/kinnector-warden)** (aka **[warden](src/warden)**): The server-side receiver and administrator that manages agent connections, coordinates security rule distribution, and routes alerts.
* **[kinnector-docker](src/kinnector-docker)**: Dockerfiles and compose setups for containerized Warden instances and network sidecars.
* **[kinnector-collect](src/kinnector-collect)**: Shared helper scripts and utilities for database queries and data parsing.

---

## 🛡️ WordPress Runtime Security

For protecting WordPress instances from remote file inclusion, arbitrary code execution, and database manipulation.

```
[HTTP Request] ──> [WordPress Kernel] ──> [src/wpwarden (PHP Plugin)] ──> [Heuristic Validation]
```

### Primary Repositories & Submodules
* **[kinnector-wordpress](src/kinnector-wordpress)** (aka **[wpwarden](src/wpwarden)**): The plug-and-play WordPress security plugin that hooks runtime operations to intercept PHP exploits before execution.

---

## ⚙️ Shared Core Components

Common libraries, design systems, and database configurations shared across all **kinnector** products:

* **[kinnector-config](src/kinnector-config)**: High-performance configuration library written in Rust and C++ for parsing and validating cryptographically signed rules.
* **[kinnector-protect-community](src/kinnector-protect-community)**: The central catalog of open security rules, attack indicators, allowlists, and detection signatures.
* **[kinnector-design](src/kinnector-design)**: Atmospheric design spec, core typography rules, and shared asset sheets.
* **[kinnector-docs](src/kinnector-docs)**: Developer references, specifications, and platform architecture guides.

---

## 🛠️ Build Orchestration

A root-level `Makefile` is provided to quickly compile or configure any component from the root of the workspace.

```bash
# View available build targets and options
make help

# Build all compilation-required components (core, agent, cli, desktop, config, warden)
make all

# Build individual components
make core      # Build C++ telemetry engine
make agent     # Build Rust agent daemon
make cli       # Build Rust CLI utility
make desktop   # Build Svelte/Vite UI dashboard
make config    # Build Rust rule validation library
make warden    # Build Rust fleet coordinator

# Clean build artifacts across all subprojects
make clean
```

---

## 🚀 Getting Started

To clone this repository and initialize all submodules in one command:

```bash
git clone --recursive https://github.com/kinnector/kinnector.git
```

If you have already cloned the repository without submodules, fetch them using:

```bash
git submodule update --init --recursive
```

---

<p align="center">
  <sub>&copy; 2026 Kinnector. All rights reserved.</sub>
</p>

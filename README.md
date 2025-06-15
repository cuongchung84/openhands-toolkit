# OpenHands Toolkit (v1.0) 🖐

A lightweight local development environment for [OpenHands](https://github.com/All-Hands-AI/OpenHands), powered by Docker.

---

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Initialize the Environment](#initialize-the-environment)
- [Usage](#usage)

---

## Overview

The **OpenHands Toolkit** simplifies the local setup process for OpenHands by leveraging Docker containers. This allows contributors and developers to quickly bootstrap their environment with minimal manual configuration.

Repository: [OpenHands GitHub](https://github.com/All-Hands-AI/OpenHands)

---

## Prerequisites

Before proceeding, ensure you have the following installed on your machine:

- [Docker](https://www.docker.com/get-started)
- [Git](https://git-scm.com/)

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/cuongchung84/openhands-toolkit.git
cd openhands-toolkit
```

### 2. Prepare the environment

Set execute permission for the bootstrap script and run it:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```
The bootstrap.sh script will prepare the environment for the first-time setup.

---

## Usage

After the initial bootstrap, you can manage your local environment using `make` commands.

The available commands are:

| Command           | Description                     |
|--------------------|----------------------------------|
| `make build`       | Build the Docker image          |
| `make rebuild`     | Force rebuild the image         |
| `make run`         | Start the OpenHands container   |
| `make shell`       | Attach to the running container |
| `make clean`       | Remove the built Docker image   |
| `make show-config` | Display the loaded configuration |

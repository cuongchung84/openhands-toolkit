# Load env with fail-safe protection
ENV_FILE=.env
ifeq ("$(wildcard $(ENV_FILE))","")
    $(error ❌ Missing .env file! Run './bootstrap.sh' to create one.)
endif

# Include env vars safely
include $(ENV_FILE)
export $(shell sed 's/=.*//' $(ENV_FILE))

# Configurable parameters
IMAGE_NAME=my-openhands
FULL_IMAGE=$(IMAGE_NAME):$(OPENHANDS_VERSION)
CONTAINER_NAME=openhands-app

.DEFAULT_GOAL := help

# Preflight safety checks
preflight:
	@command -v docker >/dev/null 2>&1 || { echo >&2 "❌ Docker is not installed."; exit 1; }
	@docker info >/dev/null 2>&1 || { echo >&2 "❌ Docker daemon not running."; exit 1; }
	@echo "✅ Docker daemon running."

# Build logic
build: preflight
	@echo "🔨 Building image: $(FULL_IMAGE)"
	docker build \
		--build-arg OPENHANDS_VERSION=$(OPENHANDS_VERSION) \
		-t $(FULL_IMAGE) .

rebuild: preflight
	@echo "🔄 Rebuilding image: $(FULL_IMAGE)"
	docker build --no-cache \
		--build-arg OPENHANDS_VERSION=$(OPENHANDS_VERSION) \
		-t $(FULL_IMAGE) .

run: preflight
	@echo "🚀 Running container: $(CONTAINER_NAME)"
	docker run -it --rm \
		-e SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:$(RUNTIME_VERSION) \
		-e LOG_ALL_EVENTS=true \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v ${HOME}/.openhands-state:/.openhands-state \
		-p 3000:3000 \
		--add-host host.docker.internal:host-gateway \
		--name $(CONTAINER_NAME) \
		$(FULL_IMAGE)

shell:
	@echo "🔧 Attaching shell into running container: $(CONTAINER_NAME)"
	docker exec -it $(CONTAINER_NAME) /bin/bash || echo "⚠️ Container not running."

clean:
	@echo "🧹 Removing image: $(FULL_IMAGE)"
	docker rmi $(FULL_IMAGE) || true

show-config:
	@echo "🔧 Loaded configuration:"
	@echo "  OPENHANDS_VERSION = $(OPENHANDS_VERSION)"
	@echo "  RUNTIME_VERSION   = $(RUNTIME_VERSION)"
	@echo "  FULL_IMAGE        = $(FULL_IMAGE)"

help:
	@echo ""
	@echo "🧰 OpenHands Toolkit v1.0"
	@echo ""
	@echo "Usage:"
	@echo "  make build        Build docker image"
	@echo "  make rebuild      Force rebuild image"
	@echo "  make run          Start OpenHands container"
	@echo "  make shell        Attach into running container"
	@echo "  make clean        Remove built docker image"
	@echo "  make show-config  Display loaded config"
	@echo ""

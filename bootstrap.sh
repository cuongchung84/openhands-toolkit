#!/bin/bash

set -e

ENV_FILE=".env"

echo "🚀 Starting OpenHands Dev Toolkit bootstrap..."

# Check if .env file exists
if [ -f "$ENV_FILE" ]; then
    echo "✅ Existing .env file found: $ENV_FILE"
else
    echo "⚠️  No .env file found. Creating template..."

    cat <<EOF > $ENV_FILE
# OpenHands versions (EDIT ME)
OPENHANDS_VERSION=0.42
RUNTIME_VERSION=0.42-nikolaik
EOF

    echo "✅ Created .env template. Please edit '$ENV_FILE' to set your versions!"
fi

echo "✅ Bootstrap complete!"

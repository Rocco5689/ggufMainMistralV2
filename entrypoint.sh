#!/bin/bash
set -euo pipefail

mkdir -p /models

if [ ! -f "/models/model.gguf" ] && [ -n "${MODEL_URL:-}" ]; then
    echo "Downloading model from MODEL_URL ..."
    curl -fL --progress-bar -o /models/model.gguf "${MODEL_URL}"
    size=$(wc -c < /models/model.gguf | tr -d ' ')
    if [ "${size}" -lt 1000000 ]; then
        echo "Download looks too small (${size} bytes) — aborting"
        rm -f /models/model.gguf
        exit 1
    fi
    echo "Download completed: /models/model.gguf ($(du -h /models/model.gguf | cut -f1))"
elif [ -f "/models/model.gguf" ]; then
    echo "Model already exists at /models/model.gguf"
else
    echo "No MODEL_URL and no /models/model.gguf — llama-server may fail to start."
fi

echo "Starting llama-server ..."
exec /app/llama-server "$@"

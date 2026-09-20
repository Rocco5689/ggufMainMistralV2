#!/bin/bash

# Create models directory (just in case)
mkdir -p /models

# Download the model if it doesn't exist and MODEL_URL is provided
if [ ! -f "/models/model.gguf" ] && [ -n "${MODEL_URL}" ]; then
    echo "📥 Downloading model from ${MODEL_URL} ..."
    curl -L --progress-bar -o /models/model.gguf "${MODEL_URL}"
    
    if [ $? -eq 0 ]; then
        echo "✅ Download completed: /models/model.gguf"
        echo "   Size: $(du -h /models/model.gguf | cut -f1)"
    else
        echo "❌ Download failed!"
        exit 1
    fi
elif [ -f "/models/model.gguf" ]; then
    echo "✅ Model already exists at /models/model.gguf"
else
    echo "⚠️  No MODEL_URL provided and no model found. llama-server may fail to start."
fi

# Execute llama-server with all arguments from CMD + any extra args
echo "🚀 Starting llama-server on port 8080..."
exec /app/llama-server "$@"

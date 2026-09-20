# llama.cpp CUDA HTTP server — TinyLlama by default (pulled at runtime)
FROM ghcr.io/ggml-org/llama.cpp:server-cuda

# curl for runtime model download via MODEL_URL
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /models

# Default model: TinyLlama 1.1B Chat Q2_K (not baked into the image)
# Override at runtime with -e MODEL_URL=... or mount a file at /models/model.gguf
ENV MODEL_URL="https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q2_K.gguf"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

# Defaults tuned for TinyLlama smoke tests; override at docker run / RunPod as needed
CMD [ \
    "--model", "/models/model.gguf", \
    "--port", "8080", \
    "--host", "0.0.0.0", \
    "--ctx-size", "2048", \
    "--n-gpu-layers", "999", \
    "--temp", "0.8", \
    "--top-k", "40", \
    "--top-p", "0.95", \
    "--min-p", "0.05", \
    "--repeat-penalty", "1.1" \
]

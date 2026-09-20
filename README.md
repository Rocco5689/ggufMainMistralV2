# ggufMainMistralV2

llama.cpp CUDA server image sources (V2). Default test model is **TinyLlama 1.1B Chat Q2_K**.

## MODEL_URL (primary)

```
https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q2_K.gguf
```

Local copy on Mac (already downloaded):

```
~/models/tinyllama-1.1b-chat-v1.0.Q2_K.gguf
```

(~461 MB — do **not** commit the `.gguf` into git; mount it at runtime.)

### Example run (local file)

```bash
docker run --rm -p 8080:8080 \
  -v "$HOME/models/tinyllama-1.1b-chat-v1.0.Q2_K.gguf:/models/model.gguf:ro" \
  <your-image> \
  --model /models/model.gguf --port 8080 --host 0.0.0.0 --n-gpu-layers 999
```

### Example run (download via MODEL_URL)

```bash
docker run --rm -p 8080:8080 \
  -e MODEL_URL="https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q2_K.gguf" \
  <your-image>
```

## Other MODEL_URL options (legacy / larger)

- https://huggingface.co/bartowski/cognitivecomputations_Dolphin3.0-R1-Mistral-24B-GGUF/resolve/main/cognitivecomputations_Dolphin3.0-R1-Mistral-24B-Q5_K_S.gguf (~16 GB)
- https://ggufstor5566stor.blob.core.windows.net/gguf/mymodel.gguf
- https://huggingface.co/mradermacher/MN-Violet-Lotus-12B-GGUF/resolve/main/MN-Violet-Lotus-12B.Q5_K_M.gguf

## Docker Hub Repository
- cavallo5689/llama-gguf-server:v4

## Volume mount path
- `/models`

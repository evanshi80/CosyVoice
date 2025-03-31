#!/bin/bash

# 启动 vLLM 服务（后台运行）
python3 -m vllm.entrypoints.openai.api_server \
  --host 0.0.0.0 \
  --port 8000 \
  --model Qwen/Qwen2.5-14B-Instruct-AWQ \
  --max-model-len 5000 \
  --gpu-memory-utilization 0.5 \
  --enable-auto-tool-choice \
  --tool-call-parser hermes &

# 启动 CosyVoice gRPC 服务（前台运行）
python async_cosyvoice/runtime/async_grpc/server.py \
  --load_jit \
  --load_trt \
  --fp16 \
  --port ${RUNPOD_TCP_PORT_70000:-50000}

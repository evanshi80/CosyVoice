# 使用官方 Python 3.10 镜像
FROM python:3.10-slim

# 安装系统依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sox libsox-dev build-essential cmake curl git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 拷贝当前目录所有文件（含 CosyVoice、async_cosyvoice、模型等）
COPY . .

# 安装 Python 依赖
RUN pip install --upgrade pip && \
    pip install -r async_cosyvoice/requirements.txt && \
    pip install pynini==2.1.5


# 设置默认启动命令
EXPOSE 50000
CMD ["python", "async_cosyvoice/runtime/async_grpc/server.py"]

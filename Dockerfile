# 使用官方 Python 3.10 镜像
FROM python:3.10-slim

# 安装系统依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sox libsox-dev build-essential cmake curl git  git-lfs\
    && rm -rf /var/lib/apt/lists/* \
    && git lfs install

# 设置工作目录
WORKDIR /app

# 1. 先 COPY requirements，便于缓存
COPY requirements/ ./requirements/

# 2. 安装 Python 依赖（如果 requirements 没变，就能缓存住）
RUN pip install --upgrade pip && \
    pip install pynini==2.1.5
RUN pip install -r requirements/01-core.txt
RUN pip install -r requirements/02-ml.txt
RUN pip install -r requirements/03-optional.txt

# 3. 然后再 COPY 剩下的代码
COPY . .

RUN chmod +x /app/entrypoint.sh

# 启动服务
CMD ["sh", "-c", "./entrypoint.sh"]

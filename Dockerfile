# ============================================================
# Ombre Brain + Gateway Docker Build (合并版)
# 同时运行 MCP Server (端口8000) 和 Gateway (端口8010)
# Zeabur 暴露 8010 端口给 Gateway
# ============================================================

FROM python:3.12-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY *.py .
COPY dashboard.html .
COPY config.example.yaml ./config.yaml

# Persistent mount points
VOLUME ["/app/buckets", "/app/state"]

# Environment defaults
ENV OMBRE_TRANSPORT=streamable-http
ENV OMBRE_BUCKETS_DIR=/app/buckets
ENV OMBRE_STATE_DIR=/app/state

# Expose Gateway port (Zeabur maps this)
EXPOSE 8010

# Start script: run MCP server in background, Gateway in foreground
COPY start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]

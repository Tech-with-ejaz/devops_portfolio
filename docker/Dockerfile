# =========================================================
# Stage 1: Build & Dependency Stage
# =========================================================
FROM python:3.12-slim AS builder

WORKDIR /app

# Prevent Python from writing .pyc files and enable unbuffered logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install required packages into a local wheels or user environment
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# =========================================================
# Stage 2: Final Production Stage
# =========================================================
FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/home/appuser/.local/bin:${PATH}" \
    PYTHONPATH="/app/src"

# Create a non-privileged user for security best practices
RUN useradd --create-home --shell /bin/bash appuser

# Copy installed Python packages from builder stage
COPY --from=builder /root/.local /home/appuser/.local

# Copy application source code into container
COPY src /app/src

# Set ownership to the non-root user
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port 5000 for Flask
EXPOSE 5000

# Health check instruction for container orchestration
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

# Default command to run the Flask app
CMD ["python3", "src/app.py"]





# How to Test Your Dockerfile
#vRun these commands from your root directory (devops_portfolio):

#vBash
# 1. Build the Docker image from root context using the docker/Dockerfile
# docker build -t devops-portfolio:v1 -f docker/Dockerfile .

# 2. Run the container in detached mode mapping port 5000
# docker run -d -p 5000:5000 --name portfolio-app devops-portfolio:v1

# 3. Test the endpoints
# curl http://localhost:5000/health
# curl http://localhost:5000/

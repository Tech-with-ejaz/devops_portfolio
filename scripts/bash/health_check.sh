#!/usr/bin/env bash
# ==============================================================================
# Script Name: health_check.sh
# Description: Verifies the health endpoint of the Flask portfolio application 
#              with built-in retry logic for container startup synchronization.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

# Configuration parameters (can be overridden by environment variables)
HOST="${HOST:-localhost}"
PORT="${PORT:-5000}"
URL="http://${HOST}:${PORT}/health"
MAX_RETRIES=5
RETRY_INTERVAL=2

echo "=================================================="
echo "Checking Application Health at: ${URL}"
echo "=================================================="

attempt=1
while [ $attempt -le $MAX_RETRIES ]; do
    # Use curl to capture the HTTP status code silently (-s), discarding output (-o /dev/null)
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || echo "000")

    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "✅ SUCCESS: Application is healthy! (HTTP Status: 200)"
        exit 0
    fi

    echo "⏳ Attempt $attempt/$MAX_RETRIES: Service not ready yet (Status: $HTTP_STATUS). Retrying in ${RETRY_INTERVAL}s..."
    sleep "$RETRY_INTERVAL"
    attempt=$((attempt + 1))
done

echo "❌ ERROR: Health check failed. Service did not respond with 200 OK after $MAX_RETRIES attempts."
exit 1

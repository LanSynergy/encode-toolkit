FROM python:3.12-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pyproject.toml README.md LICENSE ./
COPY src/ src/

# Install the package
RUN pip install --no-cache-dir .

# Run as non-root user
RUN useradd -m -r mcpuser && chown -R mcpuser /app
USER mcpuser

EXPOSE 8000

# The MCP server will look for MCP_TRANSPORT and bind to 0.0.0.0
ENTRYPOINT ["encode-toolkit"]

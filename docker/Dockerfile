FROM python:3.12-slim

# Build dependencies required to compile llama-cpp-python
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY probes/ ./probes/

ENV PYTHONUNBUFFERED=1

CMD ["python", "src/eval_runner.py"]

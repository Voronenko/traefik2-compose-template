FROM intelanalytics/ipex-llm-inference-cpp-xpu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV OLLAMA_HOST=0.0.0.0:11434

COPY ./scripts/serve.sh /usr/share/lib/serve.sh

ENTRYPOINT ["/bin/bash", "/usr/share/lib/serve.sh"]

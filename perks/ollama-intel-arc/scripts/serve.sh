#!/bin/sh

cd /llm/scripts/
source ipex-llm-init --gpu --device Arc

mkdir -p /llm/ollama
cd /llm/ollama
init-ollama
./ollama serve

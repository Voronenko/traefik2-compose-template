# Run Ollama using your Intel Arc GPU

A Docker-based setup for running Ollama as a backend and Open WebUI as a frontend, leveraging Intel Arc Series GPUs on Linux systems.

## Overview
This repository provides a convenient way to run Ollama as a backend and Open WebUI as a frontend, allowing you to interact with Large Language Models (LLM) using an Intel Arc Series GPU on your Linux system.  

![screenshot](resources/open-webui.png)

## Services
1. Ollama  
   * Runs llama.cpp and Ollama with IPEX-LLM on your Linux computer with Intel Arc GPU.  
   * Built following the guidelines from [Intel](https://github.com/intel/ipex-llm/blob/main/docs/mddocs/DockerGuides/README.md).  
   * Uses the official [Intel ipex-llm docker image](https://hub.docker.com/r/intelanalytics/ipex-llm-inference-cpp-xpu) as the base container.
   * Uses the latest versions of required packages, prioritizing cutting-edge features over stability.  
   * Exposes port `11434` for connecting other tools to your Ollama service.

2. Open WebUI  
   * The official distribution of Open WebUI.  
   * `WEBUI_AUTH` is turned off for authentication-free usage.  
   * `ENABLE_OPENAI_API` and `ENABLE_OLLAMA_API` flags are set to off and on, respectively, allowing interactions via Ollama only.  

## Setup
Run the following commands to start your Ollama instance
```bash
$ git clone https://github.com/eleiton/ollama-intel-arc.git
$ cd ollama-intel-arc
$ podman compose up
```

## Validate
Run the following command to verify your Ollama instance is up and running
```bash
$ curl http://localhost:11434/
Ollama is running
```
When using Open WebUI, you should see this partial output in your console, indicating your arc gpu was detected
```bash
[ollama-intel-arc] | Found 1 SYCL devices:
[ollama-intel-arc] | |  |                   |                                       |       |Max    |        |Max  |Global |                     |
[ollama-intel-arc] | |  |                   |                                       |       |compute|Max work|sub  |mem    |                     |
[ollama-intel-arc] | |ID|        Device Type|                                   Name|Version|units  |group   |group|size   |       Driver version|
[ollama-intel-arc] | |--|-------------------|---------------------------------------|-------|-------|--------|-----|-------|---------------------|
[ollama-intel-arc] | | 0| [level_zero:gpu:0]|                     Intel Arc Graphics|  12.71|    128|    1024|   32| 62400M|         1.6.32224+14|
```

## Usage
* Open your web browser to http://localhost:3000 to access the Open WebUI web page.  
* For more information on using Open WebUI, refer to the official documentation at https://docs.openwebui.com/ .

## Updating the images
Before any updates, be sure to stop your containers
```bash
$ podman compose down 
```

### ollama-intel-arc Image
If there are new updates in the [ipex-llm docker image](https://hub.docker.com/r/intelanalytics/ipex-llm-inference-cpp-xpu), you may want to update the Ollama image and containers, to stay updated.

First check any containers running the docker image, and remove them
```bash
$ podman ps -a
CONTAINER ID  IMAGE
111479fde20f  localhost/ollama-intel-arc:latest

$ podman rm <CONTAINER ID> 
```

The go ahead and remove the docker image:
```bash
$ podman image list
REPOSITORY                     TAG
localhost/ollama-intel-arc     latest

$ podman rmi <IMAGE ID>
```
After that, you can run compose up, to rebuild the image from scratch
```bash
$ podman compose up
```
### open-webui Image
If there are new updates in Open WebUI, just do a pull and the new changes will be retrieved automatically.
```bash
$ podman compose pull
```

## Manually connecting to your Ollama container
You can connect directly to your Ollama container by running these commands:

```bash
$ podman exec -it ollama-intel-arc /bin/bash
$ /llm/ollama/ollama -v
```

## My development environment:
* Core Ultra 7 155H
* Intel® Arc™ Graphics (Meteor Lake-P)
* Fedora 41

## References 
* [Open WebUI documentation](https://docs.openwebui.com/)
* [Intel - ipex-llm](https://github.com/intel/ipex-llm/blob/main/docs/mddocs/DockerGuides/docker_cpp_xpu_quickstart.md)

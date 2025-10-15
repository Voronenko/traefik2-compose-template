REPO_URL=git@github.com:mermaid-js/mermaid-live-editor.git
IMAGE_NAME=softasap/mermaild-live-editor
TAG=latest

all: clone-or-update build push

clone-or-update:
	@if [ -d "mermaid-live-editor" ]; then \
		echo "Updating repository..."; \
		cd mermaid-live-editor && git pull; \
	else \
		echo "Cloning repository..."; \
		git clone $(REPO_URL) mermaid-live-editor; \
	fi

build:
	cd mermaid-live-editor && docker build -t $(IMAGE_NAME):$(TAG) .

push:
	docker push $(IMAGE_NAME):$(TAG)

.PHONY: all clone-or-update build push

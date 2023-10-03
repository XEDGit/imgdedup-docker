NAME = dedup

V = v1

TAG = $(NAME):$(V)

VOLUME = ./output:/output

all: build run

build:
	@docker build -t $(TAG) .

run: build
	@echo 'Running container...'
	@docker run -v $(VOLUME) $(TAG)

clean:
	@echo 'Removing container...'
	@docker rm $(shell docker ps -aqf ancestor=$(TAG))

rc: run clean

.PHONY: all build run clean rc

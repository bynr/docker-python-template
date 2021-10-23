.DEFAULT_GOAL := help
MAKEFILE_PATH := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
PROJECT_ROOT := $(abspath $(MAKEFILE_PATH))
SRC_PATHS = src/ tests/
RUN_CMD=jupyter lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root
HOST_JUPYTER_PORT?=8888

build:
	docker build \
	-t mydevcontainer/notebook \
	-f Dockerfile .

run:
	docker run -d \
	-v $(PROJECT_ROOT):/workspace \
	--env-file=.env \
	-p $(HOST_JUPYTER_PORT):8888 \
	--name dev-notebook \
	mydevcontainer/notebook $(RUN_CMD)
	echo "If you run this container locally, go to http://localhost:$(HOST_JUPYTER_PORT)"

mount-src:
	docker rm -f mysrc || echo
	docker create -v /workspace --name mysrc alpine:3.4 /bin/true
	docker cp $(PROJECT_ROOT)/src mysrc:/workspace/
	docker cp $(PROJECT_ROOT)/tests mysrc:/workspace/

unittest: mount-src
	docker run -it \
	--env-file=.env \
	--volumes-from mysrc \
	mydevcontainer/notebook pytest $(TEST_OPTS)

logs:
	docker logs dev-notebook

follow:
	docker logs -f dev-notebook

rm:
	docker rm -f dev-notebook || echo

bash:
	docker exec -it dev-notebook bash

help:
	cat $(MAKEFILE_PATH)/Makefile

install-linters:
	pip3 install flake8==4.0.1 black==21.9b0 isort==5.9.3

lint:
	isort --check --profile black $(SRC_PATHS)
	black --check --line-length=88 $(SRC_PATHS)
	flake8 $(SRC_PATHS)

fix-lint:
	isort --profile black $(SRC_PATHS)
	black --line-length=88 $(SRC_PATHS)

clean:
	find . \( -name \*.pyc -o -name saml.html -o -name \*.pyo -o -name .mypy_cache -o -name .pytest_cache -o -name .ipynb_checkpoints -o -name __pycache__ \) -prune -exec rm -rf {} +

install-mypy:
	pip3 install mypy==0.910

mypy:
	mypy --ignore-missing-imports --strict-optional --disallow-untyped-calls $(SRC_PATHS)

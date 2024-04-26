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
	echo "If you run this container locally, go to http://localhost:$(HOST_JUPYTER_PORT)."
	echo "If a password is requested, check the container logs with 'make logs' and copy the url with the token."

unittest:
	docker exec -it dev-notebook pytest $(TEST_OPTS)

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

install-linter:
	pip3 install ruff==0.4.2

lint:
	ruff check

fix-lint:
	ruff check --fix

clean:
	find . \( -name \*.pyc -o -name saml.html -o -name \*.pyo -o -name .mypy_cache -o -name .pytest_cache -o -name .ipynb_checkpoints -o -name __pycache__ \) -prune -exec rm -rf {} +

install-mypy:
	pip3 install mypy==1.10.0

mypy:
	mypy --ignore-missing-imports --strict-optional --disallow-untyped-calls $(SRC_PATHS)

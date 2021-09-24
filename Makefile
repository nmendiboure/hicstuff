.PHONY: build install test clean deploy apidoc
TAG = $(shell git describe --tags)

install:
	pip install -e .

uninstall:
	pip uninstall hicstuff

clean:
	rm -rf build/ dist/

build: clean
	python setup.py sdist bdist_wheel

deploy: build
	twine upload dist/*

apidoc:
	sphinx-apidoc -f -o docs/api hicstuff

test:
	pytest --doctest-modules --pylint --pylint-error-types=EF --pylint-rcfile=.pylintrc hicstuff tests

dockerhub:
	docker build -t "koszullab/hicstuff:$(TAG)" .
	docker push "koszullab/hicstuff:$(TAG)"

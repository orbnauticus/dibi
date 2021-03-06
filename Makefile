
PYTHON=python3
SETUP=$(PYTHON) setup.py

VERSION=$(shell $(SETUP) --version)
FULLNAME=$(shell $(SETUP) --fullname)
NAME=$(shell $(SETUP) --name)

SRCFILES=$(shell find $(NAME) test -name '*.py' -o -name 'test_parameters.conf')

TESTPYTHON=cd $(PWD)/build/lib; $(PYTHON)

.PHONY: test all sdist

all: build

test: build
	find -path ./build -prune -o -name '*.py' -exec pep8 --show-source '{}' \;
	@cp test_parameters.conf build/lib || true
	$(TESTPYTHON) -m test

build: $(SRCFILES)
	@rm -r build || true
	@$(SETUP) build
	@touch build

sdist: $(FULLNAME).tar.gz

$(FULLNAME).tar.gz:
	@$(SETUP) sdist

#create multi-line usage/help message for makefile
define USAGE
*******************************************************
This is abusing Makefile (using make target)
to simplify some shell-commands related to this project
*******************************************************
target:
*******************************************************
setup:					zzzz
install:				gggg
test:					ggggg
validate-circleci:		vvvv
run-circleci-local:		bbbb
lint: 					ggg
all:					uuuu
help: 					this help message
*******************************************************
endef
export USAGE

#get current dir name
#https://stackoverflow.com/questions/18136918/how-to-get-current-relative-directory-of-your-makefile
export current_dir = $(notdir $(shell pwd))


help:
	@echo "$${USAGE}"


setup:
	python3 -m venv ~/.udacity-devops

install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

validate-circleci:
	# See https://circleci.com/docs/2.0/local-cli/#processing-a-config
	circleci config process .circleci/config.yml

run-circleci-local:
	# See https://circleci.com/docs/2.0/local-cli/#running-a-job
	# https://support.circleci.com/hc/en-us/articles/7060937560859-How-to-resolve-error-storage-opt-is-supported-only-for-overlay-over-xfs-with-pquota-mount-option-when-running-jobs-locally-with-the-cli
	# https://github.com/CircleCI-Public/circleci-cli/issues/301
	circleci local execute -v ~/environment/tmp:/repo --job build

lint:
	hadolint demos/flask-sklearn-student-starter/Dockerfile
	pylint --disable=R,C,W1203 demos/**/**.py

all: install lint test

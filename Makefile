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
	# simple add ....
	circleci local execute

lint:
	hadolint demos/flask-sklearn-student-starter/Dockerfile
	pylint --disable=R,C,W1203 demos/**/**.py

all: install lint test

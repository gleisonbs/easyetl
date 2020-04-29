FROM python:3.8.2-buster

WORKDIR /app

RUN apt update
RUN apt -y install pipenv

RUN pipenv run
RUN pipenv install --dev

COPY . .

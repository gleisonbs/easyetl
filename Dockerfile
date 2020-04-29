FROM python:3.8.2-buster

WORKDIR /app

RUN apt update
RUN apt -y install pipenv
RUN pipenv install

COPY . .

CMD ["python", "app.py"]
FROM python:3.7-alpine

RUN apk update && apk upgrade

COPY . /app
WORKDIR /app

ENV FLASK_DEBUG=1
ENV FLASK_APP=main.py

RUN pip3 install -r requirements.txt

CMD ["flask","run", "--host=0.0.0.0","--port=8000"]
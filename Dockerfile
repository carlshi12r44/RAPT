FROM python:3.7

RUN mkdir /usr/app
WORKDIR /usr/app

COPY . .

RUN pip install -r backend/requirements.txt

CMD python3 app.py

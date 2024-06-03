FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN chmod +w main.py


RUN pip install --no-cache-dir flask

EXPOSE 4444

ENV FLASK_APP=main.py


CMD ["python", "main.py"]


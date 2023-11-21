# Use Python 3.6 or later as a base image

FROM python:3.6

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5500

ENV YOUR_NAME QA="Long"

ENTRYPOINT ["python","app.py"]
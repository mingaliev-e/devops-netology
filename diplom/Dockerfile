FROM python:3.8

RUN mkdir -p app/

WORKDIR /app
COPY ./requirements.txt ./zbx_assistent.py /app

RUN pip3 install -r requirements.txt

ENV BOT_TOKEN="your_bot_token"
ENV ZABBIX_URL="your_zabbix_url"

CMD ["python3.8", "zbx_assistent.py"]
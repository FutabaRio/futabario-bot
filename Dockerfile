FROM python:3.10

WORKDIR /futabario

COPY ./requirements.txt .

RUN python3 -m pip install -r requirements.txt

ENTRYPOINT ["nb", "run"]
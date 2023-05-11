FROM python:3.10 as requirements_stage

WORKDIR /wheel

RUN python -m pip install --user pipx

COPY ./pyproject.toml \
  ./requirements.txt \
  /wheel/


RUN python -m pip wheel --wheel-dir=/wheel --no-cache-dir --requirement ./requirements.txt

RUN python -m pipx run --no-cache nb-cli generate -f /tmp/bot.py


FROM python:3.10-slim

WORKDIR /app

ENV TZ Asia/Shanghai
ENV PYTHONPATH=/app


RUN pip install --no-cache-dir gunicorn uvicorn[standard] nonebot2 \
  && pip install --no-cache-dir --no-index --force-reinstall --find-links=/wheel -r /wheel/requirements.txt && rm -rf /wheel
COPY . /app/

CMD ["nb","run"]
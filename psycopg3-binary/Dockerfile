FROM public.ecr.aws/lambda/python:3.13

RUN dnf install -y zip

RUN pip install --upgrade pip && \
    pip install "psycopg[binary]" --target /opt/python

RUN cd /opt && zip -r /opt/psycopg3-binary-layer.zip python

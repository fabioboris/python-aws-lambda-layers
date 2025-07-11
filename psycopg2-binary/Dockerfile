FROM public.ecr.aws/lambda/python:3.13

RUN dnf install -y zip

RUN pip install psycopg2-binary --target /opt/python

RUN cd /opt && zip -r /opt/psycopg2-binary-layer.zip python

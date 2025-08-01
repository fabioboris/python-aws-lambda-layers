FROM public.ecr.aws/lambda/python:3.13

RUN dnf install -y zip

RUN pip install python-jose --target /opt/python

RUN cd /opt && zip -r /opt/python-jose-layer.zip python

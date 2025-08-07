FROM public.ecr.aws/lambda/python:3.13

RUN dnf install -y zip

RUN pip install requests --target /opt/python

RUN cd /opt && zip -r /opt/requests-layer.zip python

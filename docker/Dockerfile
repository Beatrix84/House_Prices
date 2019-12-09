FROM ageron/handson-ml2
USER root
COPY docker/requirements.txt /
RUN pip install -r /requirements.txt
RUN jupyter contrib nbextension install
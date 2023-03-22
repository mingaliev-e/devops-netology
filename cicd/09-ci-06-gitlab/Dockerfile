FROM centos:7

RUN yum install gcc openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel wget make -y

RUN wget https://www.python.org/ftp/python/3.7.11/Python-3.7.11.tgz  && \
    tar xzf Python-3.7.11.tgz && \
    cd Python-3.7.11 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm -f Python-3.7.11.tgz

WORKDIR /opt
COPY requirements.txt /opt/requirements.txt
    
RUN pip3.7 install -r requirements.txt

RUN mkdir python_api
COPY python-api.py python_api/python-api.py


CMD ["python3.7", "python_api/python-api.py"]

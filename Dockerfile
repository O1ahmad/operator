FROM python:slim-buster

ENV FLASK_APP=/src/app
ENV ROLES_DIR=/roles
ENV COLLECTIONS_DIR=/collections

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt install -y python3-pip sshpass git openssh-client libhdf5-dev libssl-dev libffi-dev && \
    rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /src
ADD src/requirements.txt /src/requirements.txt
RUN pip install -r /src/requirements.txt

COPY src /src

COPY ansible/O1labs/crypto/roles /roles
COPY ansible/O1labs/cloud/roles /roles

RUN mkdir /collections

#         web
#          ↓
EXPOSE 1001/tcp

CMD ["flask", "run", "--host=0.0.0.0", "--port=1001"]

FROM python

RUN mkdir /tmp/dcos-cli
RUN apt-get update && apt-get install -y wget curl python-pip less tmux

RUN pip install virtualenv httpie

ENV DCOS_CONFIG=/root/.dcos/dcos.toml

ADD https://s3.amazonaws.com/downloads.mesosphere.io/dcos-cli/install.sh /tmp/
RUN /bin/bash /tmp/install.sh /tmp/dcos-cli http://localhost || true

RUN wget -qO- https://downloads.mesosphere.io/java/jre-8u51-linux-x64.tar.gz | tar xvz -C /opt/

RUN cd /usr/bin && wget http://stedolan.github.io/jq/download/linux64/jq && chmod +x jq

ENV JAVA_HOME=/opt/jre1.8.0_51

RUN echo "source /tmp/dcos-cli/bin/env-setup" >> ~/.bashrc

CMD /bin/bash


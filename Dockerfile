FROM ubuntu:16.04
LABEL maintainer="amolpratap"

# Install dependencie
RUN apt-get update \
    && apt-get install -y software-properties-common curl \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get remove -y software-properties-common \
    && apt autoremove -y \
    && apt-get update \
    && apt-get install -y python3.6 \
    && curl -o /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" \
    && python3.6 /tmp/get-pip.py \
    && apt-get remove -y curl \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

#Install ansible vesrion 2.9.9
RUN pip3 install ansible==2.9.9 \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man

#Downloading NTC-Templates 
RUN apt-get update && apt-get -y install git \
   && git clone https://github.com/networktocode/ntc-templates.git 

#Setting Environment Variable for NTC-Templates 
RUN export NET_TEXTFSM=/ntc-templates/templates

#Install Python dependencies
RUN pip3 install paramiko \
    && pip3 install textfsm 
    && apt-get -y install python3-netaddr
    && apt-get -y install vim \

VOLUME [ "/ansible" ]


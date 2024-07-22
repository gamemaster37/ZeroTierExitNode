FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install iptables -y && apt-get install iproute2 -y && apt-get install curl -y && apt-get install iptables-persistent -y

COPY first_run.sh /bin/first_run.sh
RUN chmod +x /bin/first_run.sh

ENTRYPOINT ["/bin/bash","/bin/first_run.sh"]


FROM ubuntu:22.04

RUN apt update && apt -y upgrade && apt -y install curl wget openssh-server iproute2

RUN URL=https://www.aapanel.com/script/install_7.0_en.sh && \
if [ -f /usr/bin/curl ];then curl -ksSO "$URL" ;else wget --no-check-certificate -O install_7.0_en.sh "$URL";fi; \
bash install_7.0_en.sh aapanel -y

RUN echo '8888' > /www/server/panel/data/port.pl && \
  service bt restart firewall-cmd --permanent --zone=public --add-port=8888/tcp firewall-cmd --reload

EXPOSE 8888

# Start CloudPanel
CMD service bt start && bt 14 && echo "Navigate to http://localhost:8888$(</www/server/panel/data/admin_path.pl) to login" &&  while true; do sleep 10000; done

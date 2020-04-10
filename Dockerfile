FROM centos:latest

RUN yum install -y epel-release && \
	yum install -y openvpn unzip net-tools && \
	curl -sS "https://www.privateinternetaccess.com/openvpn/openvpn-strong.zip" -o /strong.zip && \
	unzip -q /strong.zip -d /pia/strong && \
	rm -f /strong.zip && \
	curl -sS "https://www.privateinternetaccess.com/openvpn/openvpn.zip" -o /normal.zip && \
	unzip -q /normal.zip -d /pia/normal && \
	rm -f /normal.zip && \
	yum remove -y epel-release unzip && \
	yum clean all && \
	groupadd -r vpn

COPY openvpn.sh /bin/openvpn.sh
WORKDIR /pia

ENV REGION="US East"
ENV CONNECTIONSTRENGTH="strong"
ENTRYPOINT ["openvpn.sh"]

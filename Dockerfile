FROM centos:7

ADD epel-release.armhf.sh .
RUN ./epel-release.armhf.sh

RUN yum install -y epel-release && \
	yum install -y openvpn unzip net-tools iptables && \
	curl -sS "https://www.privateinternetaccess.com/openvpn/openvpn-strong.zip" -o /temp.zip && \
	unzip -q /temp.zip -d /pia && \
	rm -f /temp.zip && \
	yum remove -y epel-release unzip && \
	yum clean all && \
	groupadd -r vpn

COPY openvpn.sh /bin/openvpn.sh
WORKDIR /pia

ENV REGION="US East"
ENTRYPOINT ["openvpn.sh"]

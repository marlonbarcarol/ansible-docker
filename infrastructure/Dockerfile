FROM alpine:3.16

RUN apk add --no-cache --update \
  bash curl logrotate nano netcat-openbsd sudo openssh-server openssh-sftp-server git python3

RUN echo -e '/---/----/= Alpine with SSH 🕳 =/---/----/\n' > /etc/motd \
  && sed -n 's/#Port 22/Port 2222/' /etc/ssh/sshd_config \
  && sed -n 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
  && ssh-keygen -A

COPY --chmod=100 start.sh /root/start.sh

EXPOSE 2222

CMD ["/root/start.sh"]

FROM gitlab/gitlab-ce:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN echo 'postfix postfix/main_mailer_type select Internet Site' | debconf-set-selections \
 && echo 'postfix postfix/mailname string gitlab.example.com' | debconf-set-selections \
 && apt-get update \
 && apt-get install -y \
      rsyslog \
      postfix \
      mailutils \
 && sed -i '/# Wait for SIGTERM/ i\# Start postfix service.' /assets/wrapper \
 && sed -i '/# Wait for SIGTERM/ i\service rsyslog start' /assets/wrapper \
 && sed -i '/# Wait for SIGTERM/ i\service postfix start' /assets/wrapper \
 && sed -i '/# Wait for SIGTERM/ i\' /assets/wrapper \
 && cleanimage

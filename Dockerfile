FROM sameersbn/ubuntu:14.04.20160504
MAINTAINER sameer@damagehead.com

ENV WOWZA_VERSION=4.5.0 \
    WOWZA_DATA_DIR=/var/lib/wowza \
    WOWZA_LOG_DIR=/var/log/wowza

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget supervisor openjdk-7-jre expect \
 && rm -rf /var/lib/apt/lists/*

# ADD WowzaStreamingEngine-4.5.0-linux-x64-installer.run /app/WowzaStreamingEngine.run
COPY prepare.sh interaction.exp /app/
RUN /app/prepare.sh

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

VOLUME ["${WOWZA_DATA_DIR}", "${WOWZA_LOG_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]

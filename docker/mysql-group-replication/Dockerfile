FROM mysql:5.7.19
MAINTAINER mengli <dream83619@gmail.com>

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
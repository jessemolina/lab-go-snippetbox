FROM mysql:5.7.37-debian

ENV MYSQL_DATABASE snippetbox
ENV MYSQL_USER ${MYSQL_USER}
ENV MYSQL_PASSWORD ${MYSQL_PASSWORD}

COPY scripts/sql/build_snippetbox.sql /docker-entrypoint-initdb.d/

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="jessemolina/snippetbox-db" \
      org.opencontainers.image.authors="Jesse Molina <jesse@jessemolina.xyz>" \
      org.opencontainers.image.source="https://github.com/jessemolina/lab-go-snippetbox/" \
      org.opencontainers.image.revision="${BUILD_REF}" \
      org.opencontainers.image.vendor="Jesse Molina"

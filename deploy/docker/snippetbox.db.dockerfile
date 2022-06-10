FROM mysql:5.7.37-debian

ARG BUILD_REF default
ARG BUILD_DATE default
ARG MYSQL_ROOT_PASSWORD default
ARG MYSQL_USER default
ARG MYSQL_PASSWORD default

ENV MYSQL_DATABASE snippetbox
ENV MYSQL_ROOT_PASSWORD ${MYSQL_ROOT_PASSWORD}
ENV MYSQL_USER ${MYSQL_USER}
ENV MYSQL_PASSWORD ${MYSQL_PASSWORD}

COPY scripts/sql/build_snippetbox.sql /docker-entrypoint-initdb.d/

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="jessemolina/snippetbox-db" \
      org.opencontainers.image.authors="Jesse Molina <jesse@jessemolina.xyz>" \
      org.opencontainers.image.source="https://github.com/jessemolina/lab-go-snippetbox/" \
      org.opencontainers.image.revision="${BUILD_REF}" \
      org.opencontainers.image.vendor="Jesse Molina"

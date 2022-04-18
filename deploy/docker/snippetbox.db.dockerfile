FROM mysql:5.7.37-debian

# apt update
# apt install python-pip3
# pip3 install ansible

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="jessemolina/snippetbox-dbapi" \
      org.opencontainers.image.authors="Jesse Molina <jesse@jessemolina.xyz>" \
      org.opencontainers.image.source="https://github.com/jessemolina/lab-go-snippetbox/" \
      org.opencontainers.image.revision="${BUILD_REF}" \
      org.opencontainers.image.vendor="Jesse Molina"

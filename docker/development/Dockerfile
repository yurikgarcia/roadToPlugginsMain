FROM harbor.hulk.beast-code.com/base-images/alpine3-19-net8-node20:latest

# Installs supervisor and bind-tools for DNS resolution.
RUN apk add --no-cache supervisor bind-tools

# Copies the supervisor configuration and setup script.
COPY docker/development/supervisord.conf docker/development/run-dev.bash /root/

# Ensures the setup script is executable.
RUN chmod +x /root/run-dev.bash

CMD ["bash", "-c", "/root/run-dev.bash"]
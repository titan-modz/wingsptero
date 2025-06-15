FROM alpine:latest

LABEL maintainer="Azim <azimpr2000@gmail.com>"
LABEL description="Universal Docker container for Pterodactyl Wings"

# Environment
ENV WINGS_VERSION=latest
ENV WINGS_BINARY_URL=https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64

# System deps
RUN apk add --no-cache \
    bash \
    curl \
    iptables \
    ip6tables \
    eudev \
    ca-certificates \
    coreutils \
    tzdata \
    xz \
    sqlite \
    && update-ca-certificates

# Create necessary folders
RUN mkdir -p /etc/pterodactyl /var/lib/pterodactyl /var/log/pterodactyl

# Download Wings
ADD ${WINGS_BINARY_URL} /usr/local/bin/wings
RUN chmod +x /usr/local/bin/wings

# Set volume mounts
VOLUME ["/etc/pterodactyl", "/var/lib/pterodactyl", "/var/log/pterodactyl"]

# Expose common game server ports and Wings API
EXPOSE 8080 2022

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/wings"]

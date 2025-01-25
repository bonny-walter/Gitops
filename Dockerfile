# Start with the official Alpine 3.15 image as the base image
FROM alpine:3.15

# Install required dependencies
RUN apk add --no-cache \
    curl \
    git \
    less \
    openssh-client \
    gnupg \
    && \
    # Add Kubernetes APT repository key and install kubectl
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' > /etc/apt/sources.list.d/kubernetes.list && \
    apk add --no-cache kubectl && \
    # Clean up
    rm -rf /var/cache/apk/*

# Create a mount point for the volume
VOLUME /workspace

# Set the working directory
WORKDIR /workspace

# Set the default command to be executed when the container starts
CMD ["sh"]

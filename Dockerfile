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
    # Install kubectl directly from the Kubernetes release
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    # Clean up
    rm -f kubectl

# Create a mount point for the volume
VOLUME /workspace

# Set the working directory
WORKDIR /workspace

# Set the default command to be executed when the container starts
CMD ["sh"]

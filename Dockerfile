# Start with the official Alpine 3.15 image as the base image
# Start with the official Ubuntu image as the base image
FROM ubuntu:latest

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    less \
    openssh-client \
    apt-transport-https \
    ca-certificates \
    gnupg && \
    # Add Kubernetes APT repository and install kubectl
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl && \
    # Clean up to reduce image size
    rm -rf /var/lib/apt/lists/*

# Create a mount point for the volume
VOLUME /workspace

# Set the working directory
WORKDIR /workspace

# Set the default command to be executed when the container starts
CMD ["sh"]

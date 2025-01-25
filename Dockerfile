# Start with the official Alpine 3.15 image as the base image
FROM  ubuntu:latest

# Install required dependencies:
# - git: For interacting with Git repositories
# - less: For viewing content in the terminal
# - openssh: For SSH functionality, often useful for secure connections
# We use --no-cache to prevent apk from caching the index files, which reduces the image size.
RUN apt update && apt upgrade -y && \
    apt install -y  curl git less openssh && \
    # Download kubectl binary for Kubernetes version v1.18.6 (you can change the version if needed)
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
    sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list && \
    sudo apt-get update && \
    sudo apt-get install -y kubectl && \
    # Make kubectl executable
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*  
# Create a mount point for the volume /workspace
# This allows the container to share data with the host machine or other containers.
VOLUME /workspace

# Set the working directory to /workspace
# Any subsequent commands will be executed inside this directory.
WORKDIR /workspace

# Optional: Set the default command to be executed when the container starts
# In this case, it will open an interactive shell session by default
CMD ["sh"]
    

# Start with the official Alpine 3.15 image as the base image
FROM alpine:3.15

# Install required dependencies:
# - git: For interacting with Git repositories
# - less: For viewing content in the terminal
# - openssh: For SSH functionality, often useful for secure connections
# We use --no-cache to prevent apk from caching the index files, which reduces the image size.
RUN apk --no-cache add git less openssh && \
    # Download kubectl binary for Kubernetes version v1.18.6 (you can change the version if needed)
    wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.31/bin/linux/amd64/kubectl && \
    # Make kubectl executable
    chmod +x /usr/local/bin/kubectl && \
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

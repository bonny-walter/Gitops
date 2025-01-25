# Start with the official Ubuntu image as the base image
FROM alpine:3.21.2



# Install required dependencies
RUN sudo apk update && sudo apk upgrade && \
    sudo apk add curl && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    sudo chmod +x kubectl && \
    sudo mv kubectl /usr/local/bin/

   

# Create a mount point for the volume
VOLUME /workspace

# Set the working directory
WORKDIR /workspace

# Set the default command to be executed when the container starts
CMD ["sh"]

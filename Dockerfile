# Use Ubuntu as base image
FROM ubuntu:latest

# Set working directory
WORKDIR /opt

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Download and install Jackett
RUN wget -Nc https://github.com/Jackett/Jackett/releases/latest/download/Jackett.Binaries.LinuxAMDx64.tar.gz \
    && tar -xzf Jackett.Binaries.LinuxAMDx64.tar.gz -C /opt \
    && rm -f Jackett.Binaries.LinuxAMDx64.tar.gz \
    && chmod +x /opt/Jackett/jackett

# Set the working directory to Jackett folder
WORKDIR /opt/Jackett

# Expose the default Jackett port
EXPOSE 9117

# Create a log directory
RUN mkdir -p /opt/Jackett/logs

# Update the CMD to include logging and error handling
CMD ["/bin/bash", "-c", "while true; do ./Jackett >> /opt/Jackett/logs/jackett.log 2>&1; echo \"Jackett exited with code $? at $(date)\" >> /opt/Jackett/logs/jackett.log; sleep 10; done"]

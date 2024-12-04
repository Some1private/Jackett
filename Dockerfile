# Use Ubuntu as base image
FROM ubuntu:latest

# Install required dependencies
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /opt

# Install Jackett
RUN wget -Nc https://github.com/Jackett/Jackett/releases/latest/download/Jackett.Binaries.LinuxAMDx64.tar.gz \
    && tar -xzf Jackett.Binaries.LinuxAMDx64.tar.gz \
    && rm -f Jackett.Binaries.LinuxAMDx64.tar.gz \
    && cd Jackett \
    && chown -R root:root "/opt/Jackett"

# Expose the default Jackett port
EXPOSE 9117

# Set working directory to Jackett
WORKDIR /opt/Jackett

# Run Jackett
CMD ["./jackett"]

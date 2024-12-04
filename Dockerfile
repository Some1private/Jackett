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
    && tar -xzf Jackett.Binaries.LinuxAMDx64.tar.gz \
    && rm -f Jackett.Binaries.LinuxAMDx64.tar.gz

# Set the working directory to Jackett folder
WORKDIR /opt/Jackett

# Expose the default Jackett port
EXPOSE 9117

# Run Jackett
CMD ["./Jackett"]

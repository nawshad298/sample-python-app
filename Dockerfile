FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Python, pip and required packages
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-dev \
        build-essential && \
    rm -rf /var/lib/apt/lists/*

# Creating Application Source Code Directory
RUN mkdir -p /usr/src/app

# Setting Home Directory for container
WORKDIR /usr/src/app

# Copy requirements first for Docker layer caching
COPY requirements.txt /usr/src/app/

# Installing Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy application source code
COPY . /usr/src/app

# Application Environment variables
ENV PORT=8080

# Expose application port
EXPOSE 8080

# Persistent data
VOLUME ["/app-data"]

# Run Python application
CMD ["gunicorn", "-b", ":8080", "-c", "gunicorn.conf.py", "main:app"]

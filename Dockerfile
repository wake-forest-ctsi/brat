# For more information, please refer to https://aka.ms/vscode-docker-python
# FROM python:3.8-slim
FROM python:2.7.18

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY . /app

# Create and activate a virtual environment
RUN python -m virtualenv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

RUN python -m pip install --upgrade pip \
    && python -m pip install -r requirements.txt

# Install pip requirements
# COPY requirements.txt .
RUN python -m pip install -r requirements.txt

ARG DEBUG=False
ENV DEBUG=$DEBUG

COPY ./config_docker.py /app/config.py
RUN mkdir -p /app/data \
    && mkdir -p /app/work

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["python", "standalone.py"]

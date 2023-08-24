FROM python:3.8-slim

ENV PYSPARK_MAJOR_PYTHON_VERSION=3

# Configure Poetry
ENV POETRY_VERSION=1.2.0
ENV PYSPARK_PYTHON=/usr/bin/python3

WORKDIR /opt/application/

# Install OpenJDK 16
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://download.java.net/java/GA/jdk16.0.1/7147401fd7354114ac51ef3e1328291f/9/GPL/openjdk-16.0.1_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-16.0.1_linux-x64_bin.tar.gz && \
    rm openjdk-16.0.1_linux-x64_bin.tar.gz && \
    mv jdk-16.0.1 /usr/local && \
    apt-get clean && \
    update-alternatives --install /usr/bin/java java /usr/local/jdk-16.0.1/bin/java 1

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/local/jdk-16.0.1

COPY poetry.lock pyproject.toml /opt/application/

RUN pip install poetry

RUN poetry install --no-interaction

COPY . /opt/application/

EXPOSE 5000

CMD ["poetry", "run", "python3", "main.py"]

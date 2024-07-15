# Use the latest Ubuntu image
FROM ubuntu:latest

WORKDIR /tmp

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
  apt-utils \
  curl \
  unzip \
  gnupg \
  cron \
  lsb-release \
  && apt-get clean

# Add PostgreSQL APT Repository
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install PostgreSQL CLI version 15
RUN apt-get update && apt-get install -y \
    postgresql-client-15 \
    && apt-get clean

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install Gum
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
RUN apt update && apt install gum

RUN apt install vim -y

# Add a hello world message to the login
RUN echo "echo 'Bem vindo ao backup postgres'" >> /root/.bashrc

WORKDIR /app

ADD backup.sh backup.sh
RUN chmod +x backup.sh

COPY gummenu.sh gummenu.sh
RUN chmod +x gummenu.sh

# Add the cron job
RUN (crontab -l ; echo "0 7-19/2 * * * /usr/local/bin/backup.sh") | crontab -

# ENV POSTGRES_DATABASE **None**
# ENV POSTGRES_BACKUP_ALL **None**
# ENV POSTGRES_HOST **None**
# ENV POSTGRES_PORT 5432
# ENV POSTGRES_USER **None**
# ENV POSTGRES_PASSWORD **None**
# ENV POSTGRES_EXTRA_OPTS ''
# ENV S3_ACCESS_KEY_ID **None**
# ENV S3_SECRET_ACCESS_KEY **None**
# ENV S3_BUCKET **None**
# ENV S3_FILE_NAME **None**
# ENV S3_REGION us-west-1
# ENV S3_ENDPOINT **None**
# ENV S3_S3V4 no
# ENV SCHEDULE **None**
# ENV ENCRYPTION_PASSWORD **None**

# Set the default command to run cron and then start a bash shell
CMD cron && /bin/bash
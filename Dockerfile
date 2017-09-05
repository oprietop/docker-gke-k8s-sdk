FROM google/cloud-sdk:alpine
MAINTAINER Oscar Prieto <oscarmpp@gmail.com>

# Install kubectl
RUN gcloud components install kubectl

# Copy our wrapper
COPY run.sh /usr/local/bin/run.sh

# Just in case
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]

FROM alpine:3.18.3

ARG TERRAFORM=1.2.7
ARG TERRAGRUNT=0.38.7
ARG KUBECTL=1.26.8

RUN apk add --update --no-cache bash git openssh aws-cli curl

# Install terraform 
RUN wget https://releases.hashicorp.com/terraform/1.2.7/terraform_1.2.7_linux_amd64.zip && \
    unzip terraform_1.2.7_linux_amd64.zip && rm terraform_1.2.7_linux_amd64.zip && \
    mv terraform /usr/bin/terraform

# Install terragrunt
ADD https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT}/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN chmod +x /usr/local/bin/terragrunt

# Install kubectl
RUN apk add --update --no-cache curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

WORKDIR /apps

ENTRYPOINT []

ARG BASE_IMAGE=centos:7

FROM ${BASE_IMAGE}
ARG  LOCKED_PACKAGES

USER root

RUN [[ ! -z "$LOCKED_PACKAGES" ]] && \
    yum -y install yum-plugin-versionlock && \
    yum versionlock add $LOCKED_PACKAGES && \
    yum clean all || \
    exit 0

# Update the image with the latest packages
RUN yum update -y; yum clean all

ENV PUPPET_VERSION 3.8.7

RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm && \
    yum install -y puppet-$PUPPET_VERSION && \
    yum clean all

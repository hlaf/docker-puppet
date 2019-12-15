ARG  BASE_IMAGE=centos:7
FROM ${BASE_IMAGE}

# Update the image with the latest packages
RUN yum update -y; yum clean all

ENV PUPPET_VERSION 3.8.7

RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm && \
    yum install -y puppet-$PUPPET_VERSION && \
    yum clean all

RUN FACTER_hostname=initialize.dockerbuilder /usr/bin/puppet agent --server puppet --environment dockerbuilder --verbose --onetime --no-daemonize --show_diff --summarize

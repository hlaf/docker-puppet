#!groovy

@Library('emt-pipeline-lib@master') _

image_name = 'hlaf/puppet'
puppet_master = 'puppet-01'

node('docker-slave') {

    stage('Checkout') {
        checkout scm
    }

    stage('Build image') {
        domain_name = getDnsDomainName()
        image_fqdn = 'initialize.dockerbuilder.' + domain_name
        deletePuppetCertificate(image_fqdn, 'puppet_management_node', puppet_master)
        sh "docker build -t ${image_name} --no-cache --build-arg PUPPET_MASTER=${puppet_master}.${domain_name} ."
    }

    stage('Push image') {
        /* Push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            docker.image(image_name).push("${env.BUILD_NUMBER}")
            docker.image(image_name).push("latest")
        }
    }
}

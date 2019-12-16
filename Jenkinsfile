#!groovy

@Library('emt-pipeline-lib@master') _

image_name = 'hlaf/puppet'

node('docker-slave') {

    stage('Checkout') {
        checkout scm
    }

    stage('Build image') {
        domain_name = getDnsDomainName()
        image_fqdn = 'initialize.dockerbuilder.' + domain_name
        deletePuppetCertificate(image_fqdn)
        sh "docker build -t ${image_name} --no-cache ." 
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

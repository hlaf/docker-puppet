#!groovy

@Library('emt-pipeline-lib@master') _

image_name = 'hlaf/puppet'

node('docker-slave') {

    stage('Checkout') {
        checkout scm
    }

    stage('Build image') {
        domain_name = getDnsDomainName()
        sh "docker build -t ${image_name} --no-cache ."
    }

    stage('Push image') {
        // Tag the image with the incremental build number from Jenkins
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            docker.image(image_name).push("${env.BUILD_NUMBER}")
        }
    }
}

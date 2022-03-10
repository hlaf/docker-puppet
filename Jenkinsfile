#!groovy

@Library('emt-pipeline-lib@master') _

boolean is_headless = env.JOB_BASE_NAME.contains('headless')

if (is_headless) {
  image_name = 'hlaf/centos7-puppet-headless'
  build_args = "--build-arg BASE_IMAGE=consol/centos-xfce-vnc:1.4.0 --build-arg LOCKED_PACKAGES='tigervnc*'"
} else {
  image_name = 'hlaf/puppet'
  build_args = ''
}

node('docker-slave') {

    stage('Checkout') {
        checkout scm
    }

    stage('Build image') {
        domain_name = getDnsDomainName()
        sh "docker build -t ${image_name} --no-cache ${build_args} ."
    }

    stage('Push image') {
        // Tag the image with the incremental build number from Jenkins
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            docker.image(image_name).push("${env.BUILD_NUMBER}")
        }
    }
}

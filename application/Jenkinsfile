@Library('jenkins-shared-library')_

pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io/omarshaban32'
        DOCKER_IMAGE = 'omarshaban32/spring-boot-app'
        DockerHubCredentialsID = 'docker-registry-credentials-id'
        OpenshiftCredentialsID = 'openshift-token-credentials-id'
        OPENSHIFT_PROJECT = 'nti'
        OPENSHIFT_SERVER = 'https://api.ocp-training.ivolve-test.com:6443'
        nameSpace = 'ahlamahmed'
    }

    stages {
        stage('unittest') {
            steps {
                script {
                    unittest()
                }
            }
        }


        stage('buildunittest') {
            steps {
                script {
                    buildunittest()
                }
            }
        }

        stage('sonarqube') {
            steps {
                script {
                    sonarQubeAnalysis()
                }
            }
        }



        stage('Build and push Docker Image') {
            steps {
                script {
                    buildpushDockerImage("${DockerHubCredentialsID}", "${DOCKER_IMAGE}") 
                }
            }
        }

        
        stage('edit Docker Image') {
            steps {
                script {
                    editNewImage("${DOCKER_IMAGE}")
                }
            }
        }



        stage('Deploy to OpenShift') {
            steps {
                script {
                    dir('oc') {
                        deployOnOc("${OpenshiftCredentialsID}", "${nameSpace}", "${OPENSHIFT_SERVER}") 
                    }
                }
            }
        }
    }
}

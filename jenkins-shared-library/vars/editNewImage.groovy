#!/usr/bin/env groovy

def call(String DOCKER_IMAGE) {

                sh '''
                    sed -i "s|image:.*|image: ${DOCKER_IMAGE}:${BUILD_NUMBER}|g" oc/deployment.yaml
                   '''
    
}


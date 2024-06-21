#!usr/bin/env groovy
def call(String dockerHubCredentialsID, String DOCKER_IMAGE) {

	// Log in to DockerHub 
	withCredentials([usernamePassword(credentialsId: "${dockerHubCredentialsID}", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
		sh "docker login -u ${USERNAME} -p ${PASSWORD}"
        }
        
        // Build and push Docker image
        echo "Building and Pushing Docker image..."
        sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
        sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"	 
}

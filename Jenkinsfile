pipeline {
    agent any
    
    stages {
		stage('Build') {
			steps {
				sh "docker build -t ${env.DOCKER_IMAGE} ."
			}
		}

		stage('Push Docker Image') {
			steps {
				withDockerRegistry([url: '', credentialsId: 'docker-credentials-id']) {
					sh "docker push ${env.DOCKER_IMAGE}"
				}
			}
		}
		
        stage('Deploy') {
        	steps {
        		ansiblePlaybook(
        			installation: 'ansible',
        			disableHostKeyChecking: true,
        			playbook: 'deploy.yml',
        			inventory: 'target,',
        			extraVars: [
        				TARGET_HOST: "${env.TARGET_HOST}",
        				TARGET_USER: "${env.TARGET_USER}",
        				TARGET_PATH: "${env.TARGET_PATH}",
        				DOCKER_IMAGE: "${env.DOCKER_IMAGE}"
        			],
        			vaultCredentialsId: 'ansible_pass'
        		)
        	}
        }
    }

    post {
    	always {
    		cleanWs()
    	}
    }
}

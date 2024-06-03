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
				withDockerRegistry([url: 'https://ttl.sh/', credentialsId: 'docker-credentials-id']) {
					sh "docker push ${env.DOCKER_IMAGE}"
				}
			}
		}
		
        stage('Deploy') {
        	steps {
        		ansiblePlaybook(
        			becomeUser: 'vagrant',
        			installation: 'ansible',
        			disableHostKeyChecking: true,
        			playbook: 'deploy.yml',
        			inventory: 'inventory',
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

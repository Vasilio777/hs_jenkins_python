pipeline {
    agent any
    
    stages {
		stage('Build') {
			steps {
				sh "docker build -t ${env.TTL_DOCKER_IMAGE}:1h ."
			}
		}

		stage('Push Docker Image') {
			steps {
				sh "docker push ${env.TTL_DOCKER_IMAGE}:1h"
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
        				TARGET_PATH: "${env.TARGET_PATH}",
        				DOCKER_IMAGE: "${env.TTL_DOCKER_IMAGE}:1h"
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

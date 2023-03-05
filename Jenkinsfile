pipeline {
    agent any
    stages{
        stage('Git checkout') {
            steps {
                git url:'https://github.com/yasharabbasov/pgdo_cp1.git',branch:'main'
                sh 'ls' 
           }
        }
        stage('Build Docker Image') {
            steps {
                dockerImage = docker.build("yasharabbasov/pgdo_cp1:${env.BUILD_NUMBER}")
            }
        }
        stage('Push Image to Docker hub') {
            steps {
                echo "Docker Image Tag Name ---> ${dockerImageTag}"
                docker.withRegistry('', 'dockerhub') {
                    dockerImage.push("${env.BUILD_NUMBER}")
                    dockerImage.push("latest")
                }
            }
        }
        stage('Deploy container with Ansible') {
            steps{
                sh "ansible-playbook deploy.yaml"
            }
        }          
    }
}
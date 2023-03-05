pipeline {
    agent any
    tools {
        maven 'mvn'
    }
    stages{
        stage('Git checkout') {
            steps {
                git url:'https://github.com/yasharabbasov/pgdo_cp1.git',branch:'main' 
           }
        }
        stage('Maven build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Docker build') {
            steps{
                sh 'docker build -t ${JOB_NAME}:v1.${BUILD_NUMBER} .'
                sh 'docker tag ${JOB_NAME}:v1.${BUILD_NUMBER} yasharabbasov/${JOB_NAME}:v1.${BUILD_NUMBER} '
                sh 'docker tag ${JOB_NAME}:v1.${BUILD_NUMBER} yasharabbasov/${JOB_NAME}:latest '
            }
        }
        stage('Docker push') {
            steps{
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerauth')]) {
                  sh 'docker login -u yasharabbasov -p ${dockerauth}'
                  sh 'docker push yasharabbasov/${JOB_NAME}:v1.${BUILD_NUMBER}'
                  sh 'docker push yasharabbasov/${JOB_NAME}:latest'
                  sh 'docker rmi ${JOB_NAME}:v1.${BUILD_NUMBER} yasharabbasov/${JOB_NAME}:v1.${BUILD_NUMBER} yasharabbasov/${JOB_NAME}:latest'
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
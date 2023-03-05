pipeline {
    agent any
    tools {
        maven 'mvn'
    }
    stages{
        stage('Git checkout') {
            steps {
                git credentialsId: 'gitauth', url: 'github.com:yasharabbasov/pgdo_cp1.git'
           }
        }
        stage('Maven build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Docker build, tag and push') {
            def app = "pgdo_cp1"
            def dockerid = "yasharabbasov"
            def dockerImageTag = "${dockerid}/${app}:${env.BUILD_NUMBER}"
            dockerImage = docker.build("${dockerid}/${app}:${env.BUILD_NUMBER}")
            echo "Docker Image Tag Name ---> ${dockerImageTag}"
                docker.withRegistry('', 'dockerhub') {
                dockerImage.push("${env.BUILD_NUMBER}")
                dockerImage.push("latest")
            }
        }
        stage('Deploy container with Ansible') {
            steps{
                sh "ansible-playbook deploy.yaml"
            }
        }          
    }
}
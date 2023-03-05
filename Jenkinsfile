node{
    def app = "pgdo_cp1"
    def dockerid = "yasharabbasov"
    def dockerImage
    def dockerImageTag = "${dockerid}/${app}:${env.BUILD_NUMBER}"

    stages{
        stage('Git checkout') {
            git url:"https://github.com/${dockerid}/${app}.git",branch:'main'
            sh 'ls' 
        }
        stage('Build Docker Image') {
            dockerImage = docker.build("${dockerid}/${app}:${env.BUILD_NUMBER}")
        }
        stage('Push Image to Docker hub') {
            echo "Docker Image Tag Name ---> ${dockerImageTag}"
            docker.withRegistry('', 'dockerhub') {
                dockerImage.push("${env.BUILD_NUMBER}")
                dockerImage.push("latest")
            }
        }
        stage('Deploy container with Ansible') {
            sh "ansible-playbook deploy.yaml"
        }          
    }
}
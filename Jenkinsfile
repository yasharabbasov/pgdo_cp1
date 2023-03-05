node{
    def app = "pgdo_cp1"
    def userid = "yasharabbasov"
    def dockerImage
    def dockerImageTag = "${userid}/${app}:${env.BUILD_NUMBER}"

    stage('Git checkout') {
        git url:"https://github.com/${userid}/${app}.git",branch:'main'
        sh 'ls' 
    }
    stage('Build Docker Image') {
        dockerImage = docker.build("${dockerImageTag}")
    }
    stage('Push Image to Docker hub') {
        echo "Docker Image Tag Name ---> ${dockerImageTag}"
        docker.withRegistry('', 'dockerhub') {
            dockerImage.push("${env.BUILD_NUMBER}")
            dockerImage.push("latest")
        }
    }
    stage('Run container') {
        sh "docker run -d --name ${app} -p 8081:8081 ${userid}/${app}"
    }
    stage('Test the app') {
        sh "curl localhost:8081"
    }
    stage('Remove container stack') {
        sh "docker stop ${app}"
        sh "docker rm -f ${app}"
        sh "docker rmi -f ${userid}/${app}:${env.BUILD_NUMBER}"
    }
}
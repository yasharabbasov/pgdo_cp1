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
    stage('Run the container') {
        sh "docker run -d --name tomcat-container -p 8081:8080 ${userid}/${app}"
    }
    stage('Test the app') {
        sh "curl http://localhost:8081/sample"
    }
    stage('Prune docker resources') {
        sh "docker stop tomcat-container"
        sh "docker rm -f tomcat-container"
    }
}
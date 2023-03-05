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
        cmd = """
          curl -s -X GET -H 'accept: */*' -w '{http_code}' \
              'https://localhost:8081/sample/hello.jsp' 
        """

      status_code = sh(script: cmd, returnStdout: true).trim()
      // must call trim() to remove the default trailing newline
                  
      echo "HTTP response status code: ${status_code}"

      if (status_code != "200") {
          error('URL status different of 200. Exiting script.')
      } 
    }
    stage('Prune docker resources') {
        sh "docker stop tomcat-container"
        sh "docker rm -f tomcat-container"
    }
    post {
        success { echo 'Project build successfully!' }
        failure { echo 'Project build failed!' }
    }  
}
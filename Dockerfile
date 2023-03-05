FROM tomcat

LABEL maintainer="yashar.linkoln@gmail.com"

COPY sample.war /usr/local/tomcat/webapps/

EXPOSE 8081
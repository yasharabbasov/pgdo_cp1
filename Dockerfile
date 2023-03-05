FROM tomcat:8.0-alpine

LABEL maintainer=”yashar.linkoln@gmail.com”

COPY sample.war /usr/local/tomcat/webapps/

EXPOSE 8081

CMD [“catalina.sh”, “run”]
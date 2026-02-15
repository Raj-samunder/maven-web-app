FROM tomcat:latest
EXPOSE 8080
COPY target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

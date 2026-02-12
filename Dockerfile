FROM tomcat:latest
MAINTAINER Ashok <ashok@oracle.coms>
EXPOSE 8080
COPY target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

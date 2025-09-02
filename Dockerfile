# Use Tomcat base image (Java 8)
FROM tomcat:8.0.20-jre8

# Copy your WAR file
COPY target/myapp.war /usr/local/tomcat/webapps/myapp.war

# Add tomcat-users.xml for manager GUI login
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

EXPOSE 8080
CMD ["catalina.sh", "run"]


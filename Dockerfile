# Use an official Tomcat runtime as the base image
FROM tomcat:latest

# Copy the WAR file of your Java project to the Tomcat webapps directory
COPY path/to/your/onlinebookstore-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/

# Expose the port that Tomcat runs on (default is 8080)
EXPOSE 8083

# Start Tomcat when the container is run
CMD ["catalina.sh", "run"]

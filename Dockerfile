FROM tomcat:8
# Take the war and copy to webapps of tomcat web server
COPY target/newapp.war /usr/local/tomcat/webapps/

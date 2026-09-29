FROM tomcat:11-jdk21

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY LibraryManagement.war /usr/local/tomcat/webapps/ROOT.war
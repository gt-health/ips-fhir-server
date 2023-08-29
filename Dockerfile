#Build the Maven project
FROM maven:3.6.3-openjdk-17 as builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean install

#Build the Tomcat container
FROM tomcat:9.0.65-jre17
#set environment variables below and uncomment the line. Or, you can manually set your environment on your server.
#ENV JDBC_URL=jdbc:postgresql://<host>:<port>/<database> JDBC_USERNAME=<username> JDBC_PASSWORD=<password>

# ENV JDBC_URL="jdbc:postgresql://fhir_db:5432/fhirbase"
# ENV JDBC_USERNAME="postgres"      
# ENV JDBC_PASSWORD="postgres"
# ENV SMART_INTROSPECTURL="http://localhost:8080/raven-fhir-server/raven-fhir-server/smart/introspect"
# ENV SMART_AUTHSERVERURL="http://localhost:8080/raven-fhir-server/raven-fhir-server/smart/authorize"
# ENV SMART_TOKENSERVERURL="http://localhost:8080/raven-fhir-server/raven-fhir-server/smart/token"
# ENV AUTH_BASIC="client:secret"
# ENV FHIR_READONLY="False"
# ENV INTERNAL_FHIR_REQUEST_URL="http://localhost:8080/raven-fhir-server/fhir"

# Copy GT-FHIR war file to webapps.
COPY --from=builder /usr/src/app/fhir-fhirbase-server/target/fhir-fhirbase-server.war $CATALINA_HOME/webapps/ips-fhir-server.war

EXPOSE 8080

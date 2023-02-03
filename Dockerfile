FROM jelastic/springboot:openjdk-1.8.0_342
COPY delivery-0.9.0-SNAPSHOT.jar delivery/app.jar
COPY application.yml delivery/app.yaml
COPY applicationTags.yaml delivery/applicationTags.yaml
COPY wfReportingConfig.yaml wfReportingConfig.yaml
ENTRYPOINT ["/bin/sh", "-c", "java -jar ./delivery/app.jar --spring.config.location=./delivery/app.yaml > /var/log/delivery/delivery.log 2>&1"]
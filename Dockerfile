FROM jelastic/springboot:openjdk-1.8.0_342
COPY shopping-0.9.0-SNAPSHOT.jar shopping/app.jar
COPY app.yaml shopping/app.yaml
COPY applicationTags.yaml shopping/applicationTags.yaml
COPY wfReportingConfig.yaml wfReportingConfig.yaml
ENTRYPOINT ["java", "-jar", "./shopping/app.jar", "server", "./shopping/app.yaml"]

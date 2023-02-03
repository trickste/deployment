FROM jelastic/springboot:openjdk-1.8.0_342
COPY  styling-0.9.0-SNAPSHOT.jar styling/app.jar
COPY app.yaml styling/app.yaml
COPY applicationTags.yaml styling/applicationTags.yaml
COPY wfReportingConfig.yaml wfReportingConfig.yaml
ENTRYPOINT ["/bin/sh", "-c", "java -jar ./styling/app.jar server ./styling/app.yaml > /var/log/styling/styling.log 2>&1"]

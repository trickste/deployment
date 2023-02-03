FROM jelastic/springboot:openjdk-1.8.0_342
COPY printing-0.9.0-SNAPSHOT.jar printing/app.jar
COPY app.yaml printing/app.yaml
COPY applicationTags.yaml printing/applicationTags.yaml
COPY wfReportingConfig.yaml wfReportingConfig.yaml
ENTRYPOINT ["/bin/sh", "-c", "java -jar ./printing/app.jar ./printing/app.yaml -XX:ParallelGCThreads=4 > /var/log/printing/printing.log 2>&1"]
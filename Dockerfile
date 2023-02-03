FROM jelastic/springboot:openjdk-1.8.0_342
COPY packaging-0.9.0-SNAPSHOT.jar packaging/app.jar
COPY app.yaml packaging/app.yaml
COPY applicationTags.yaml packaging/applicationTags.yaml
COPY wfReportingConfig.yaml wfReportingConfig.yaml
ENTRYPOINT ["/bin/sh", "-c", "java -jar ./packaging/app.jar ./packaging/app.yaml -XX:ParallelGCThreads=4 > /var/log/packaging/packaging.log 2>&1"]
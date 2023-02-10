FROM  grafana/k6
USER root
RUN apk update && apk add bash && apk add jq

COPY /k6/SmokeTestFramework /home/k6/SmokeTestFramework
COPY /proto /home/proto
COPY /TestData /home/TestData

COPY /k6/package.json /home/k6/package.json
COPY /k6/results.js /home/k6/results.js

#ENTRYPOINT ["tail", "-f", "/dev/null"]


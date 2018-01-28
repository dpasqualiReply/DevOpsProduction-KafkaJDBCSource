#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "USAGE ./debugConsoleConsumer.sh <topic-name>"
    echo "AVAILABLE TOPICS"
    kafka-topics --zookeeper localhost:2181 --list
fi

kafka-console-consumer --new-consumer --bootstrap-server localhost:9092 --topic $1 --from-beginning
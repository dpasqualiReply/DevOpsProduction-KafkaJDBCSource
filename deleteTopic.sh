#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "USAGE ./deleteTopic <topic-name>"
    echo "AVAILABLE TOPICS"
    kafka-topics --zookeeper localhost:2181 --list
fi

kafka-topics --delete --zookeeper localhost:2181 --topic $1
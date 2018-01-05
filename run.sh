baseDir=$(dirname $0)
MAIN_CLASS="org.apache.kafka.connect.cli.ConnectStandalone"
DISTRIBUTED_CONFIG="$baseDir/config/connect-distributed.properties"
STANDALONE_CONFIG="$baseDir/config/connect-avro-standalone.properties"
CONNECTOR="$baseDir/config/source-quickstart-sqlite.properties"

JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.el7_4.x86_64/jre
JMX_PORT=18087

for file in $baseDir/libs/*.jar;
do
	#echo $file
	CLASSPATH=$CLASSPATH:$file
done

#echo "PROVA CLASSPATH "
#echo $CLASSPATH
# for dir in $baseDir/libs/*;
# do
# 	for file in $dir/*.jar;
# 	do
# 		CLASSPATH=$CLASSPATH:$file
# 	done
# done

# JMX settings
if [ -z "$KAFKA_JMX_OPTS" ]; then
	KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false "
fi

# JMX port to use
if [ $JMX_PORT ]; then
	KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -Dcom.sun.management.jmxremote.port=$JMX_PORT "
fi

# Which java to use
if [ -z "$JAVA_HOME" ]; then
	JAVA="java"
else
	JAVA="$JAVA_HOME/bin/java"
fi

# Log4j settings
if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
	KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$baseDir/config/connect-log4j.properties"
fi

# Memory options
if [ -z "$KAFKA_HEAP_OPTS"]; then
	KAFKA_HEAP_OPTS="-Xms5g -Xmx5g"
fi

# JVM performance options
if [ -z "$KAFKA_JVM_PERFORMANCE_OPTS" ]; then
	KAFKA_JVM_PERFORMANCE_OPTS="-server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+DisableExplicitGC -Djava.awt.headless=true"
fi

#rm config/connectm20.offsets

exec $JAVA $KAFKA_HEAP_OPTS $KAFKA_JVM_PERFORMANCE_OPTS $KAFKA_JMX_OPTS $KAFKA_LOG4J_OPTS -cp $CLASSPATH $MAIN_CLASS $STANDALONE_CONFIG $CONNECTOR


#!/bin/sh
. ./server.sh
export DATE=`date +%Y%m%d%H%M%S`

export JBOSS_HOME=/jboss/wildfly-9.0.2.Final
export SERVER_HOME=/jboss/domains
export SERVER_NAME=$SVCNAME

export LOG_DIR=/jb_log
export JBOSS_USER=jboss
export PORT_SET=0
#export MULTICAST_IP=225.0.0.10

export LOG_HOME=$LOG_DIR/$SERVER_NAME
export PATH=$JAVA_HOME/bin:$JBOSS_HOME/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JBOSS_HOME/lib

if [ "x$JAVA_OPTS" = "x" ]; then
   JAVA_OPTS="-server"
   JAVA_OPTS="$JAVA_OPTS -Dserver=$SERVER_NAME"
   JAVA_OPTS="$JAVA_OPTS -Djboss.server.base.dir=$SERVER_HOME/$SERVER_NAME"
   JAVA_OPTS="$JAVA_OPTS -Djboss.server.base.url=file://$SERVER_HOME/$SERVER_NAME"
   JAVA_OPTS="$JAVA_OPTS -Djboss.server.log.dir=$LOG_HOME"
   JAVA_OPTS="$JAVA_OPTS -Djboss.socket.binding.port-offset=$PORT_SET"
   JAVA_OPTS="$JAVA_OPTS -Djboss.jvmRoute=$SERVER_NAME"
   JAVA_OPTS="$JAVA_OPTS -Djboss.node.name=$SERVER_NAME"

   JAVA_OPTS="$JAVA_OPTS -Xms2048m"
   JAVA_OPTS="$JAVA_OPTS -Xmx2048m"
   
   ##jdk7
   JAVA_OPTS="$JAVA_OPTS -XX:PermSize=256m"
   JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=512m"

   ##jdk8
   #JAVA_OPTS="$JAVA_OPTS -XX:MetaspaceSize=256m"
   #JAVA_OPTS="$JAVA_OPTS -XX:MaxMetaspaceSize=512m"

   #JAVA_OPTS="$JAVA_OPTS -Xss256k"
   JAVA_OPTS="$JAVA_OPTS -XX:+UseParallelGC"

   JAVA_OPTS="$JAVA_OPTS -verbose:gc"
   JAVA_OPTS="$JAVA_OPTS -Xloggc:$LOG_HOME/gclog/gc.log.$DATE"
   JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails"
   JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCTimeStamps"
   JAVA_OPTS="$JAVA_OPTS -XX:+PrintHeapAtGC"
   JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
   JAVA_OPTS="$JAVA_OPTS -XX:HeapDumpPath=$LOG_HOME/gclog/$SERVER_NAME.$DATE.hprof"

   JAVA_OPTS="$JAVA_OPTS -Dorg.jboss.resolver.warning=true"
   JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true"
   JAVA_OPTS="$JAVA_OPTS -Dsun.rmi.dgc.client.gcInterval=3600000"
   JAVA_OPTS="$JAVA_OPTS -Dsun.rmi.dgc.server.gcInterval=3600000"
   JAVA_OPTS="$JAVA_OPTS -Dsun.lang.ClassLoader.allowArraySyntax=true "
   JAVA_OPTS="$JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman"
   JAVA_OPTS="$JAVA_OPTS -Djava.awt.headless=true"
   JAVA_OPTS="$JAVA_OPTS -Djboss.server.default.config=standalone.xml"
fi

export JAVA_OPTS

echo "================================================"
echo " JBOSS_HOME=$JBOSS_HOME"
echo "SERVER_HOME=$SERVER_HOME"
echo "SERVER_NAME=$SERVER_NAME"
echo "================================================"

#!/bin/sh
. ./env.sh

# ------------------------------------
PID=`ps -ef | grep java | grep "=$SERVER_NAME" | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBOSS($SERVER_NAME) is already RUNNING..."
    exit;
fi
# ------------------------------------
UNAME=`id -u -n`
if [ e$UNAME != "e$JBOSS_USER" ]
then
    echo "$JBOSS_USER USER to start JBoss SERVER - $SERVER_NAME..."
    exit;
fi
# ------------------------------------

if [ ! -d $LOG_HOME ]; then
    mkdir $LOG_HOME
fi
if [ ! -d $LOG_HOME/nohup ]; then
    mkdir $LOG_HOME/nohup
fi

if [ -f $LOG_HOME/nohup/$SERVER_NAME.out ]; then
    mv $LOG_HOME/nohup/$SERVER_NAME.out $LOG_HOME/nohup/$SERVER_NAME.$DATE
fi

if [ ! -d $LOG_HOME/gclog ]; then
    mkdir $LOG_HOME/gclog
fi

if [ -f $LOG_HOME/gclog/gc.log ]; then
    mv $LOG_HOME/gclog/gc.log $LOG_HOME/gclog/gc.log.$DATE
fi

##standalone.xml
nohup $JBOSS_HOME/bin/standalone.sh -b $DOMAIN_IP >> $LOG_HOME/nohup/$SERVER_NAME.out 2>&1 &

##standalone-ha.xml
#nohup $JBOSS_HOME/bin/standalone.sh -b $DOMAIN_IP -u $MULTICAST_IP >> $LOG_HOME/nohup/$SERVER_NAME.out 2>&1 &

echo "Starting... $SERVER_NAME"
#tail -f $LOG_HOME/nohup/$SERVER_NAME.out

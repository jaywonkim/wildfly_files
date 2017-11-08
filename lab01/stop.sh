#!/bin/sh

. ./env.sh
export SHUTDOWN_PORT=$(expr $PORT_SET + 9990)
$JBOSS_HOME/bin/jboss-cli.sh --controller=localhost:$SHUTDOWN_PORT --connect --command=:shutdown

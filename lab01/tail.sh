#!/bin/sh
. ./env.sh
tail -100f $LOG_HOME/nohup/$SERVER_NAME.out

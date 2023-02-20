#!/bin/bash
echo "MYSQL SETTING UP..."
mysql -uroot -p123 <<EOF
source $WORK_PATH/$SQL_FILE;

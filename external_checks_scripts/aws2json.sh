#!/bin/bash
#
# Caution! Call this script from Zabbix directly is very dangerous. Do not use in production!


AWSCMD="$1"
JQCMD="$2"
ZBXEL="$3"

FIRST=1

echo "{"
echo '    "data":['
while read line; do
    if [ $FIRST != 0 ]; then
        FIRST=0
    else
        ELEMENT="{ \"{#$ZBXEL}\":\"$ITEM\" },"
        echo "        $ELEMENT"
    fi
    ITEM=$line
done <<< "$(aws $AWSCMD | jq -r $JQCMD)"
ELEMENT="{ \"{#$ZBXEL}\":\"$ITEM\" }"
echo "        $ELEMENT"
echo '    ]'
echo "}"

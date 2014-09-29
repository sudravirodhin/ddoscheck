#!/bin/bash
# Author: Gregory Adam Conroy
# Description: Shows list (save exceptions) of currently connected IP addresses and the quantity of connections per IP.
# Alternatively shows connections by port for IP if provided as first argument.
# Use with watch for basic system monitoring.

# Set exempt IPs below
LOCAL_IPS='0.0.0.0|8.8.8.8|50.7.254'

if [ -z "$1"  ]
        then
                echo "Listing number of connections by IP..."
                netstat -punt | tail -n +3 | grep -vE "$LOCAL_IPS" | awk {'print $5'} | cut -d ":" -f 1 | sort | uniq -c | sort -rnk 1
                echo End of List...
else
        echo "Listing number of connections by port via $1..."
        netstat -punt | tail -n +3 | grep -vE "$LOCAL_IPS" | awk {'print $5'} | grep $1 | cut -d ":" -f 2 | sort | uniq -c | sort -nk 1
        echo "End of List..."
fi
exit
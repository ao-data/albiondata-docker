#!/bin/bash
# Delete anything older than 3 days
find ./db -name 'db_backup*' -type f -mtime +3 -exec rm -f {} \;

# Delete anything older than 10 minutes
# find ./db -name 'db_backup*' -type f -mmin +10 -exec rm -f {} \;
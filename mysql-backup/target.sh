#!/bin/bash

now=$(date +"%Y-%m-%dT%H_%M_%S")
name=db_backup_${now}.tgz
echo -n ${name}
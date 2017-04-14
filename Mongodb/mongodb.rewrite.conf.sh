#!/bin/sh

FILE="/usr/local/etc/mongo/mongod.conf"

/bin/cat <<EOM >$FILE
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /data/mongodb
  journal:
    enabled: true

# security
security:
    authorization: enabled

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# network interfaces
net:
  port: 27017
#  bindIp: 127.0.0.1

EOM
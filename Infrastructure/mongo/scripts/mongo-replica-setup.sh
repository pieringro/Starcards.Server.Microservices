#!/bin/bash

apt-get update
apt-get install -y dnsutils

echo "Waiting mongo instances.."
while [ -z "$MONGODB1" ] || [ -z "$MONGODB2" ] || [ -z "$MONGODB3" ] ; do
    MONGODB1=`dig +short mongo1`
    MONGODB2=`dig +short mongo2`
    MONGODB3=`dig +short mongo3`
    printf '.'
    sleep 1
done
echo "Mongo instances ready!"

echo ${MONGODB1} " Waiting for startup.."
until curl http://${MONGODB1}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

echo curl http://${MONGODB1}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1
echo "Started.."


echo SETUP.sh time now: `date +"%T" `
mongo --host ${MONGODB1}:27017 <<EOF
var cfg = {
    "_id": "my-replica",
    "version": 1,
	"protocolVersion": 1,
    "members": [
        {
            "_id": 0,
            "host": "${MONGODB1}:27017",
            "priority": 2
        },
        {
            "_id": 1,
            "host": "${MONGODB2}:27017",
            "priority": 0
        },
        {
            "_id": 2,
            "host": "${MONGODB3}:27017",
            "priority": 0
        }
    ],settings: {chainingAllowed: true}
};
rs.initiate(cfg, { force: true });
rs.reconfig(cfg, { force: true });
rs.slaveOk();
db.getMongo().setReadPref('nearest');
db.getMongo().setSlaveOk();
EOF

sleep 30

mongo --host ${MONGODB1}:27017 <<EOF
use admin;
if(db.system.users.findOne({user:'root'}) == null) {
    print("Creating user root...");
    db.createUser({
        user: 'root',
        pwd: 'root',
        roles: [{ role: 'userAdminAnyDatabase', db:'admin'}]
    });
    print("... Done.");
} else {
    print("User root already exists.");
}
EOF

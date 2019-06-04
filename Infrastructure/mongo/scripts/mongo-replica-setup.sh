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


for mongoInstance in $MONGODB1 $MONGODB2 $MONGODB3
do
    echo ${mongoInstance} " Waiting for startup.."
    until curl http://${mongoInstance}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
    printf '.'
    sleep 1
    done

    echo curl http://${mongoInstance}:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1
    echo ${mongoInstance} "Started.."
done



echo SETUP.sh time now: `date +"%T" `
mongo --host ${MONGODB1}:27017 <<EOF
print(">>>>>>>>> rs.status()");
rs.status();
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
print(">>>>>>>>> rs.initiate(cfg, force)");
rs.initiate(cfg, { force: true });
print(">>>>> rs.reconfig(cfg, force)");
rs.reconfig(cfg, { force: true });
print(">>>>>>>>> rs.slaveOk()");
rs.slaveOk();
print(">>>>>>>>> db.getMongo().setReadPref('nearest')");
db.getMongo().setReadPref('nearest');
print(">>>>>>>>> db.getMongo().setSlaveOk()");
db.getMongo().setSlaveOk();

print(">>>>>>>>> rs.status()");
rs.status();
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

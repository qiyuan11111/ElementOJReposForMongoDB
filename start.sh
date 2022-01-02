#!/bin/sh
DIRECTORY=/data/db
FLAG=0
if [ "`ls -A $DIRECTORY`" = "" ]; then
	FLAG=1
else
	FLAG=0
fi

if [ $FLAG -eq 1 ]; then
/usr/local/mongodb/bin/mongod --fork --logpath /usr/local/mongodb/mongodb.log --dbpath /data/db
/usr/local/mongodb/bin/mongo << EOF
use admin;
db.createUser({
	user:"root", 
	pwd:"ctguacm1234@",
	roles:[{
		role:"root",
		db:"admin"
	}]
});
use eloj; 
db.createUser({  
    user: "ctgu",  
    pwd: "ctguacm1234@",  
    roles: [{ 
		role: "readWrite", 
		db: "eloj" 
	}]
}); 
db.createCollection("contest_sign");
db.createCollection("contest_problem");
db.createCollection("contest_solution");
db.createCollection("contest_solution_index");
EOF
/usr/local/mongodb/bin/mongod --shutdown --dbpath /data/db
openssl rand -base64 756 > /usr/local/mongodb/repl_set.key
chmod 600 /usr/local/mongodb/repl_set.key
fi

/usr/local/mongodb/bin/mongod --fork --logpath /usr/local/mongodb/mongodb.log --replSet rs0 --keyFile /usr/local/mongodb/repl_set.key --dbpath /data/db --auth --bind_ip 0.0.0.0

if [ $FLAG -eq 1 ]; then
/usr/local/mongodb/bin/mongo << EOF
use admin;
db.auth("root", "ctguacm1234@");
rs.initiate();
cfg = rs.conf()
cfg.members[0].host = "Element-mongodb:27017"
rs.reconfig(cfg)
EOF
fi
/bin/bash
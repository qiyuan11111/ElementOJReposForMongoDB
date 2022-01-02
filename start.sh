#!/bin/sh
/usr/local/mongodb/bin/mongod --shutdown --dbpath /data/db
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
EOF
/usr/local/mongodb/bin/mongod --shutdown --dbpath /data/db
/usr/local/mongodb/bin/mongod --fork --logpath /usr/local/mongodb/mongodb.log --dbpath /data/db --auth --bind_ip 0.0.0.0
/usr/local/mongodb/bin/mongo << EOF
use admin;
db.auth("root", "ctguacm1234@");
rs.initiate();
use eloj;
db.createUser({  
    user: "ctgu",  
    pwd: "ctguacm1234@",  
    roles: [{ 
			role: "readWrite", 
			db: "eloj" 
	}]
}); 
db.createCollection("contest_enter");
db.createCollection("contest_problem");
EOF
/bin/bash
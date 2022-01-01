#!/bin/sh
mongo << EOF
use admin;
db.auth("root", "ctguacm1234@");
rs.initiate();
use eloj;
db.createUser(  
    {  
        user: "ctgu",  
        pwd: "ctguacm1234@",  
        roles: [  
            { role: "readWrite", db: "eloj" }  
        ]  
    }  
 ); 
db.createCollection("contest_enter");
db.createCollection("contest_problem");
EOF
/bin/bash
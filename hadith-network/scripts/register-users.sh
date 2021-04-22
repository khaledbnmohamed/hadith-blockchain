#!/bin/bash
node src/enrollAdmin.js producer
node src/enrollAdmin.js alazhar-university
node src/enrollAdmin.js islamicuniveristy
node src/enrollAdmin.js omelkorra-university

node src/registerUser.js producer
node src/registerUser.js alazhar-university
node src/registerUser.js islamicuniveristy
node src/registerUser.js omelkorra-university

echo "***********************************"
echo "       Starting API server         "
echo "***********************************"
npm start

#!/bin/bash
node src/enrollAdmin.js producer
node src/enrollAdmin.js alazharuniversity
node src/enrollAdmin.js islamicuniveristy
node src/enrollAdmin.js omelkorrauniversity

node src/registerUser.js producer
node src/registerUser.js alazharuniversity
node src/registerUser.js islamicuniveristy
node src/registerUser.js omelkorrauniversity

echo "***********************************"
echo "       Starting API server         "
echo "***********************************"
npm start

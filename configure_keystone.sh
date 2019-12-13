#!/bin/bash

set -x

echo -n Database

echo -n db-sync
keystone-manage db_sync  2>&1
echo " [COMPLETE]"

echo -n "bootstrap "
keystone-manage bootstrap --bootstrap-password=FreeIPA4All
echo " [COMPLETE]"

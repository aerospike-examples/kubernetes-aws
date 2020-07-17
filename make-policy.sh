#!/bin/bash

if [ -z $ACCOUNT_ID ]
then
	echo "You need to set ACCOUNT_ID to use this script"
	exit 1
fi

sed "s/account-id/$ACCOUNT_ID/" eks.iam.policy.template > eks.iam.policy

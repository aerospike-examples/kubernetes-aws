#!/bin/bash

ACCOUNT_ID=${1}

if [ -z $ACCOUNT_ID ]
then
	echo "Usage : make-policy.sh <AWS_ACCOUNT_ID>"
	exit 1
fi

sed "s/account-id/$ACCOUNT_ID/" eks.iam.policy.template > eks.iam.policy

echo "Your EKS policy has been saved as eks.iam.policy"

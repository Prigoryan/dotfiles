#!/bin/bash

# USAGE:
# source aws-mfa-login.sh <mfa-arn> <mfa-code>

RESPONSE=$(aws sts get-session-token --serial-number $1 --token-code $2)
export AWS_SECRET_ACCESS_KEY=$(echo "$RESPONSE" | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo "$RESPONSE" | jq -r '.Credentials.SessionToken')
export AWS_ACCESS_KEY_ID=$(echo "$RESPONSE" | jq -r '.Credentials.AccessKeyId')

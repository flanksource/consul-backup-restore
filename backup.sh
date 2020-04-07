#!/bin/bash

set -ex

BACKUP_FILE=$(mktemp /tmp/consul-backup.XXXXXX)

consul snapshot save -http-addr=$CONSUL_ADDR $BACKUP_FILE

SSL_OPTS=""

if [[ "$AWS_ENDPOINT" =~ ^http\:\/\/ ]]; then
  SSL_OPTS="--no-ssl"
fi

CURRENT_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="$CURRENT_TIME.snapshot"

s3cmd --host=$AWS_ENDPOINT \
      --host-bucket=$AWS_ENDPOINT/$BACKUP_BUCKET $SSL_OPTS \
      --acl-private \
      put $BACKUP_FILE s3://$BACKUP_BUCKET/$BACKUP_PATH$FILENAME

rm $BACKUP_FILE

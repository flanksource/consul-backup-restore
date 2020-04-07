#!/bin/bash

set -ex

BACKUP_FILE=$(mktemp /tmp/consul-backup.XXXXXX)
rm $BACKUP_FILE

SSL_OPTS=""

if [[ "$AWS_ENDPOINT" =~ ^http\:\/\/ ]]; then
  SSL_OPTS="--no-ssl"
fi

s3cmd --host=$AWS_ENDPOINT \
      --host-bucket=$AWS_ENDPOINT/$RESTORE_BUCKET $SSL_OPTS \
      --acl-private \
      get $RESTORE_URL $BACKUP_FILE

consul snapshot restore -http-addr=$CONSUL_ADDR $BACKUP_FILE

rm $BACKUP_FILE

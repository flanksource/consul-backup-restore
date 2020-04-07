# Consul Backup and Restore

### Configuration

It requires the following environment variables:

```
AWS_ACCESS_KEY_ID=<key>
AWS_SECRET_ACCESS_KEY=<key>
AWS_ENDPOINT=http://s3.your.host
CONSUL_ADDR=consul-server-0.consul-server.consul.svc:8500
BACKUP_BUCKET=consul-backups
BACKUP_PATH=consul/backups/consul/consul-server/
```

### Restore

Set all the required environment variables specified above, plus:

```
RESTORE_URL=s3://consul-backups/consul/backups/consul/consul-server/2020-04-07_13-50-30.snapshot
RESTORE_BUCKET=consul-backups
```

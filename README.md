ecsextender
========
Extend an ECS cluster instance with Consul and other goodies.


Example user-data
--------
The use of this container is to run consul and some other goodies on an AWS ECS
optimized AMI.  Your autoscaling group should use this user-data for proper
operation.

```
#!/bin/bash -x
cat >> /etc/rc.local <<EOF

docker pull homecu/ecsextender
docker run \
    --net host \\
    --privileged \\
    -v /var/run/docker.sock:/var/run/docker.sock \\
    -v /:/hostroot \\
    homecu/ecsextender

if [ \$? -eq 3 ] ; then
  reboot
fi

EOF
```


ENV Overrides
--------
Some options can be enabled or customized with environment variables placed in the above
instance user-data.  For example...

```
#!/bin/bash -x
cat >> /etc/rc.local <<EOF

docker pull homecu/ecsextender
docker run --net host \\
    -v /var/run/docker.sock:/var/run/docker.sock \\
    -v /:/hostroot \\
    --privileged \\
    -e OPTIONAL_ENV_ARG=somevalue \\
    homecu/ecsextender
if [ \$? -eq 3 ] ; then
  reboot
fi

EOF
```

### Supported ENV switches

1. **ELASTICSEARCH_HOST** - Centralize logging to an elasticsearch service.
   Example value: `http://search-foo-ezl00000000000BBBBBBBBBBBB.us-west-2.es.amazonaws.com`
2. **ELASTICSEARCH_GELF_URN** - URN for elasticsearch gelf logging. Eg. /docker/logs
3. **ELASTICSEARCH_TCPJSON_URN** - URN for elasticsearch tcpjson stats collection. Eg. /docker/stats

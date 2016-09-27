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

1. **ELASTICSEARCH_URL** - Centralize logging to an elasticsearch service.
   Example value: `http://search-foo-bar.us-west-2.es.amazonaws.com`
2. **ELASTICSEARCH_GELF_INDEX** - Elasticsearch index for gelf logging. Eg. logging
3. **ELASTICSEARCH_GELF_TYPE** - Elasticsearch type column for gelf logging. Eg. docker
4. **ELASTICSEARCH_TCPJSON_INDEX** - Elasticsearch index for tcpjson logging. Eg. statistics
5. **ELASTICSEARCH_TCPJSON_TYPE** - Elasticsearch type column for tcpjson logging. Eg. docker

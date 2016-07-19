ecsextender
========
Extend an ECS cluster instance with Consul and some extras.


Example user-data
--------
The use of this container is to run consul and some extras on an AWS ECS
optimized AMI.  Your autoscaling group should use this user-data for proper
operation.

```
#!/bin/bash -x
cat >> /etc/rc.local <<EOF

docker pull homecu/ecsconsul
docker run --net host \\
    -v /var/run/docker.sock:/var/run/docker.sock \\
    -v /:/hostroot \\
    --privileged \\
    homecu/ecsconsul
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

docker pull homecu/ecsconsul
docker run --net host \\
    -v /var/run/docker.sock:/var/run/docker.sock \\
    -v /:/hostroot \\
    --privileged \\
    -e OPTIONAL_ENV_ARG=somevalue \\
    homecu/ecsconsul
if [ \$? -eq 3 ] ; then
  reboot
fi

EOF
```

### Supported ENV switches

1. **ELASTICSEARCH_HOST** - Centralize logging to an elasticsearch service.
   Example value: `search-foo-ezl00000000000BBBBBBBBBBBB.us-west-2.es.amazonaws.com:80`

2. **EFS_ID** - Mount an EFS filesystem with this ID (eg. `fs-12345678`) to `/efs`

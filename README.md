ecsconsul
========
Bootstrap an ECS cluster instance with consul and some extras.


Example user-data
--------
The use of this container is to run consul and some extras on an AWS ECS
optimized AMI.  Your autoscaling group should use this user-data for proper
operation.

```
#!/bin/bash -x
cat >> /etc/rc.local <<EOF

docker run --net host \\
    -v /var/run/docker.sock:/var/run/docker.sock \\
    -v /:/hostroot \\
    -e LOGGLY_TOKEN=YOUR-LOGGLY-API-TOKEN-HERE \\
    homecu/ecsconsul
if [ \$? -eq 3 ] ; then
  reboot
fi

EOF
```

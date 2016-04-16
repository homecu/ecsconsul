odyssey-ecsbootstrap
========
To be used on ECS instances to bootstrap their env.


Example user-data
--------
```
#!/bin/bash -x
yum install -y aws-cli
$(aws ecr get-login --region us-west-2)
docker pull 265109528935.dkr.ecr.us-west-2.amazonaws.com/ecsbootstrap:latest
docker run --net host -v /var/run/docker.sock:/var/run/docker.sock -v /:/hostroot 265109528935.dkr.ecr.us-west-2.amazonaws.com/ecsbootstrap:latest
if [ $? -eq 3 ] ; then
  reboot
fi
```

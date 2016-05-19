FROM homecu/ecsbootstrap:v8

RUN pip install boto3 requests

COPY overrides /overrides
COPY run.d /run.d

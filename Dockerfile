FROM homecu/ecsbootstrap:v7

RUN pip install boto3 requests

COPY overrides /overrides
COPY run.d /run.d

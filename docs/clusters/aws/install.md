# Install

## Prerequisites

1. [Docker](https://docs.docker.com/install)
1. Subscribe to the [EKS-optimized AMI with GPU Support](https://aws.amazon.com/marketplace/pp/B07GRHFXGM) (for GPU clusters)
1. An IAM user with `AdministratorAccess` and programmatic access (see [security](security.md) if you'd like to use less privileged credentials after spinning up your cluster)

## Spin up Cortex on your AWS account

```bash
# install the CLI
pip install cortex

# spin up Cortex on your AWS account
cortex cluster up  # or: cortex cluster up --config cluster.yaml (see configuration options below)
```

## Configure Cortex

```yaml
# cluster.yaml

# EKS cluster name
cluster_name: cortex

# AWS region
region: us-east-1

# list of availability zones for your region
availability_zones:  # default: 3 random availability zones in your region, e.g. [us-east-1a, us-east-1b, us-east-1c]

# instance type
instance_type: m5.large

# minimum number of instances
min_instances: 1

# maximum number of instances
max_instances: 5

# disk storage size per instance (GB)
instance_volume_size: 50

# instance volume type [gp2 | io1 | st1 | sc1]
instance_volume_type: gp2

# instance volume iops (only applicable to io1)
# instance_volume_iops: 3000

# subnet visibility [public (instances will have public IPs) | private (instances will not have public IPs)]
subnet_visibility: public

# NAT gateway (required when using private subnets) [none | single | highly_available (a NAT gateway per availability zone)]
nat_gateway: none

# API load balancer scheme [internet-facing | internal]
api_load_balancer_scheme: internet-facing

# operator load balancer scheme [internet-facing | internal]
# note: if using "internal", you must configure VPC Peering to connect your CLI to your cluster operator
operator_load_balancer_scheme: internet-facing

# API Gateway [public (API Gateway will be used by default, can be disabled per API) | none (API Gateway will be disabled for all APIs)]
api_gateway: public

# additional tags to assign to AWS resources (all resources will automatically be tagged with cortex.dev/cluster-name: <cluster_name>)
tags:  # <string>: <string> map of key/value pairs

# enable spot instances
spot: false

# SSL certificate ARN (only necessary when using a custom domain without API Gateway)
ssl_certificate_arn:

# primary CIDR block for the cluster's VPC
vpc_cidr: 192.168.0.0/16
```

The docker images used by the Cortex cluster can also be overridden, although this is not common. They can be configured by adding any of these keys to your cluster configuration file (default values are shown):

<!-- CORTEX_VERSION_BRANCH_STABLE -->
```yaml
image_operator: quay.io/cortexlabs/operator:0.25.0
image_manager: quay.io/cortexlabs/manager:0.25.0
image_downloader: quay.io/cortexlabs/downloader:0.25.0
image_request_monitor: quay.io/cortexlabs/request-monitor:0.25.0
image_cluster_autoscaler: quay.io/cortexlabs/cluster-autoscaler:0.25.0
image_metrics_server: quay.io/cortexlabs/metrics-server:0.25.0
image_inferentia: quay.io/cortexlabs/inferentia:0.25.0
image_neuron_rtd: quay.io/cortexlabs/neuron-rtd:0.25.0
image_nvidia: quay.io/cortexlabs/nvidia:0.25.0
image_fluentd: quay.io/cortexlabs/fluentd:0.25.0
image_statsd: quay.io/cortexlabs/statsd:0.25.0
image_istio_proxy: quay.io/cortexlabs/istio-proxy:0.25.0
image_istio_pilot: quay.io/cortexlabs/istio-pilot:0.25.0
```

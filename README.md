# terraform-aws-msk

Magicorn made Terraform Module for AWS Provider
--
```
module "msk" {
  source         = "magicorntech/msk/aws"
  version        = "0.0.1"
  tenant         = var.tenant
  name           = var.name
  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  cidr_block     = module.vpc.cidr_block
  subnet_ids     = module.vpc.db_subnet_ids
  encryption     = true # 1
  kms_key_id     = module.kms.msk_key_id[0]
  additional_ips = ["192.168.43.143/32"] # should be set empty []

  # MSK Configuration
  stream_name            = "master"
  number_of_broker_nodes = 3
  kafka_version          = "3.5.1"
  instance_type          = "kafka.t3.small"
  volume_size            = 10
  server_properties      = <<PROPERTIES
auto.create.topics.enable=true
delete.topic.enable=true
default.replication.factor=3
  PROPERTIES
}

```

## Notes
1) Works better with magicorn-aws-kms module.
2) Does not support authentication (yet).

resource "aws_msk_cluster" "main" {
  cluster_name           = "${var.tenant}-${var.name}-${var.stream_name}-${var.environment}"
  number_of_broker_nodes = var.number_of_broker_nodes
  kafka_version          = var.kafka_version

  broker_node_group_info {
    instance_type   = var.instance_type
    client_subnets  = var.subnet_ids
    security_groups = [aws_security_group.main.id]

    connectivity_info {
      public_access {
        type = "DISABLED"
      }
    }

    storage_info {
      ebs_storage_info {
        volume_size = var.volume_size

        provisioned_throughput {
          enabled           = false
          volume_throughput = null
        }
      }
    }
  }

  client_authentication {
    unauthenticated = true
  }

  configuration_info {
    arn      = aws_msk_configuration.main.arn
    revision = aws_msk_configuration.main.latest_revision
  }

  dynamic "encryption_info" {
    for_each = (var.encryption == true) ? [true] : []
    content {
      encryption_at_rest_kms_key_arn = var.kms_key_id

      encryption_in_transit {
        in_cluster    = true
        client_broker = "TLS"
      }
    }
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.stream_name}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

resource "aws_msk_configuration" "main" {
  name              = "${var.tenant}-${var.name}-${var.stream_name}-config-${var.environment}"
  kafka_versions    = [var.kafka_version]
  server_properties = var.server_properties
}

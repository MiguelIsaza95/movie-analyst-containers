resource "aws_service_discovery_private_dns_namespace" "proxy" {
  name = "movieanalyst.org"
  vpc  = aws_vpc.test.id
}

resource "aws_service_discovery_service" "proxy_sd" {
  name = "proxy"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.proxy.id

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
}

resource "aws_service_discovery_private_dns_namespace" "ui" {
  name = "movieanalyst.org"
  vpc  = aws_vpc.test.id
}

resource "aws_service_discovery_service" "ui_sd" {
  name = "ui"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ui.id

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
}

resource "aws_service_discovery_private_dns_namespace" "api" {
  name = "movieanalyst.org"
  vpc  = aws_vpc.test.id
}

resource "aws_service_discovery_service" "api_sd" {
  name = "api"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.api.id

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
}
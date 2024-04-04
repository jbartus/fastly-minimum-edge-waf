terraform {
  required_providers {
    fastly = {
      source = "fastly/fastly"
    }
    sigsci = {
      source = "signalsciences/sigsci"
    }
  }
}

resource "fastly_service_vcl" "mtfew" {
  name = "minimum terraform edgewaf"

  domain {
    name = "mtfew.global.ssl.fastly.net"
  }

  backend {
    name    = "httpbin"
    address = "httpbin.org"
  }

  condition {
    name      = "all_requests"
    statement = "true"
    type      = "REQUEST"
  }

  request_setting {
    name              = "pass_all"
    action            = "pass"
    request_condition = "all_requests"
  }

  lifecycle {
    ignore_changes = [dictionary, dynamicsnippet]
  }

  force_destroy = true
}

resource "sigsci_site" "mtfew" {
  display_name = "minimum terraform edgewaf"
  short_name   = "mtfew"
  agent_level  = "log"
}

resource "sigsci_edge_deployment" "mtfew" {
  site_short_name = sigsci_site.mtfew.short_name
}

resource "sigsci_edge_deployment_service" "mtfew" {
  site_short_name  = sigsci_edge_deployment.mtfew.site_short_name
  fastly_sid       = fastly_service_vcl.mtfew.id
  activate_version = true
  percent_enabled  = 100
}
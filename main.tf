resource "fastly_service_vcl" "min-ewaf" {
  name = "minimum terraform edgewaf"

  domain {
    name = "${var.site_name}.global.ssl.fastly.net"
  }

  backend {
    name    = "origin"
    address = var.origin
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

resource "sigsci_site" "min-ewaf" {
  display_name = "minimum terraform edgewaf"
  short_name   = "min-ewaf"
  agent_level  = "log"
}

resource "sigsci_edge_deployment" "min-ewaf" {
  site_short_name = sigsci_site.min-ewaf.short_name
}

resource "sigsci_edge_deployment_service" "min-ewaf" {
  site_short_name  = sigsci_edge_deployment.min-ewaf.site_short_name
  fastly_sid       = fastly_service_vcl.min-ewaf.id
  activate_version = true
  percent_enabled  = 100
}
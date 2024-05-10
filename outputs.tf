output "vcl-svc" {
  value = "https://${var.site_name}.freetls.fastly.net"
}

output "manage" {
  value = "https://manage.fastly.com/observe/dashboard/system/overview/realtime/${fastly_service_vcl.min-ewaf.id}"
}

output "dash" {
  value = "https://dashboard.signalsciences.net/corps/${var.sigsci_corp}/sites/${var.site_name}?dashboardId=000000000000000000000001&from=-1h"
}
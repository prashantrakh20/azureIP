resource "azurerm_monitor_action_group" "azip_amag" {
  name                = "CriticalAlertsAction"
  resource_group_name = var.rsgp_name
  short_name          = "azip_action"

email_receiver {
    name          = "sendtoadmin"
    email_address = var.email_id
  }
}

resource "azurerm_monitor_metric_alert" "azip_amma" {
  name                = "my_metric_alerts"
  resource_group_name = var.rsgp_name
  scopes              = ["${var.vi_id}"]
  description         = "Action will be triggered when the Used capacity is Greater than 777 bytes."

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 85

    
    

  }

  action {
    action_group_id = "${azurerm_monitor_action_group.azip_amag.id}"
  }
}



resource "azurerm_monitor_diagnostic_setting" "azip_mds" {
  name               = "example"
  target_resource_id = var.rs_id
  
    log {
    category = "AuditEvent"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}
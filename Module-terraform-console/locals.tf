locals {
  full_name     = "${var.env}-${var.app_name}"
  storage_class = var.env == "prod" ? "Premium_LRS" : "Standard_LRS"
  labels        = [for k, v in var.settings : "${k}=${v}"]
}

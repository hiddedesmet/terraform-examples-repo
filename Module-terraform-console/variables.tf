variable "env" {
  type    = string
  default = "dev"
}

variable "app_name" {
  type    = string
  default = "frontend"
}

variable "settings" {
  type = map(any)
  default = {
    tier    = "standard"
    enabled = true
  }
}

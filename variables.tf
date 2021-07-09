variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "pb_key" {
  description = "Public key"
  type        = string
  default     = "~/pb_key.pub"
}

variable "pr_key" {
  description = "Private key"
  type        = string
  default     = "~/pb_key.pem"
}

variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list(any)
  default     = ["22", "8080"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = "false"
}

variable "common-tags" {
  description = "Common Tags to apply to all resource"
  type        = map(any)
  default = {
    Owner        = "Roman Kuznetsov"
    Project      = "Alfa"
    Envrironment = "Development"
  }
}

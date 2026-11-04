variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0a318c6ec12295c3c"
  description = "VPC to launch the builder in. Empty = default VPC of the account"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "Optional public subnet. Empty = first public subnet in the VPC that supports the instance type"
}

variable "instance_type" {
  type    = string
  default = "t3.large"
}

variable "root_volume_size" {
  type    = number
  default = 30
}

variable "allowed_cidrs" {
  type        = list(string)
  default     = []
  description = "Extra CIDRs allowed to reach the builder, e.g. your home IP [\"1.2.3.4/32\"]"
}

variable "detect_my_ip" {
  type        = bool
  default     = true
  description = "Also allow the public IP of the machine running terraform (needed for remote-exec over SSH)"
}

variable "extra_tcp_ports" {
  type        = list(number)
  default     = []
  description = "Extra TCP ports to open to the allowed CIDRs, e.g. [80] for the k3s ingress"
}

variable "open_nodeport_range" {
  type        = bool
  default     = false
  description = "Open the Kubernetes NodePort range 30000-32767 to the allowed CIDRs"
}

variable "owner" {
  type    = string
  default = "shahar"
}

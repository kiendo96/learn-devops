variable "region" {
  default = "us-east-1"
}

variable "consul_address" {
  type = string
  description = "Address of Consule Server"
  default = "127.0.0.1"
}

variable "consul_port" {
  type = number
  description = "Port Consul Server is listening on"
  default = "8500"
}

variable "consul_datacenter" {
  type = string
  description = "Name of Consule datacenter"
  default = "dc1"
}
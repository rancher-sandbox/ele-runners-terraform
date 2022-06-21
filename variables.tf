
variable "qemu_uri" {
  type    = string
  default = "qemu:///system"
  description = "Qemu url"
}

variable "memory" {
  type    = number
  default = 4096
  description = "Memory for each server"
}

variable "vcpu" {
  default = 4
  type    = number
  description = "Cpus for each server"
}

variable "servers" {
  default = 1
  type    = number
  description = "Number of servers to deploy"
}

variable "arch" {
  type    = string
  default = "x86_64"
  description = "Arch to use"
}

variable "pool_dir" {
  type    = string
  default = "/data/"
  description = "Pool dir to store the VM data"
}

variable "runner_version" {
  type    = string
  default = "2.293.0"
  description = "github runner version to use"
}

variable "github_token" {
  type      = string
  sensitive = true
  nullable  = false
  description = "PAT token to use. This is used to auto obtain runner tokens. Use a short lived token (7 days) as its no necessary after the bootstrap"
}

variable "github_repo" {
  type    = string
  default = "rancher/elemental-toolkit"
  description = "Github repo to add the runner to"
}
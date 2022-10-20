variable "f5xc_tenant" {
  type = string
}

variable "project_prefix" {
  type        = string
  description = "prefix string put in front of string"
  default     = "myproject"
}

variable "namespace" {
  type        = string
  default     = "mynamespace"
}

variable "virtual_site" {
  type        = string
  default     = "myvsite"
}

variable "vk8s_name" {
  type        = string
  default     = "myvk8s"
}

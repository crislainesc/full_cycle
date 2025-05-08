variable "prefix" {
  description = "Resource tags prefix"
  type        = string
}
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}
variable "retention_days" {
  description = "Cloud watch logs retention period"
  type        = number
}
variable "desired_size" {
  description = "Desired size of the node group"
  type        = number
}
variable "min_size" {
  description = "Minimum size of the node group"
  type        = number
}
variable "max_size" {
  description = "Maximum size of the node group"
  type        = number
}

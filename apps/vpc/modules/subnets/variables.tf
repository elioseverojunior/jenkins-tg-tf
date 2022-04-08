variable "subnets" {
  description = "AWS Subnet"
  type        = map(any)
}

variable "selected_subnets" {
  description = "description"
  type        = list(string)
  default     = []
}

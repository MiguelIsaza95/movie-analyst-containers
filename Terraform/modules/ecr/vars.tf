variable "repo_name" {
  type    = string
  default = ""
}

variable "mutability_option" {
  type    = string
  default = "MUTABLE"
}

variable "scan_on_push" {
  type    = bool
  default = true
}
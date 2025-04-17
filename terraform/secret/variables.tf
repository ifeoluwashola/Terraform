variable "app_name" {
  default = "django-app"
}

variable "secret_values" {
  type        = map(string)
  description = "Key-value pairs of environment variables"
}

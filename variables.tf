# Secret Variables
# These variables will be populated from your local terraform.tfvars file.

variable "jwt_secret" {
  description = "JWT secret for the application"
  type        = string
  sensitive   = true
}

variable "google_ai_api_key" {
  description = "Google AI API Key"
  type        = string
  sensitive   = true
}

variable "cloudinary_cloud_name" {
  description = "Cloudinary cloud name"
  type        = string
}

variable "cloudinary_api_key" {
  description = "Cloudinary API key"
  type        = string
  sensitive   = true
}

variable "cloudinary_api_secret" {
  description = "Cloudinary API secret"
  type        = string
  sensitive   = true
}

variable "email_from" {
  description = "Email address for sending emails"
  type        = string
}

variable "email_pass" {
  description = "Password for the email account"
  type        = string
  sensitive   = true
}

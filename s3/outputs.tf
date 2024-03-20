# export the s3 bucket name
output "env_file_bucket_name" {
  value = var.env_file_bucket_config.name
}

# export the environment file name
output "env_file_name" {
  value = var.env_file_name
}
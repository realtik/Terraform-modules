# create an s3 bucket 
resource "aws_s3_bucket" "env_file_bucket" {
  bucket = var.env_file_bucket_config.name

  lifecycle {
    create_before_destroy = "false"
  }
}

# upload the environment file from local computer into the s3 bucket
resource "aws_s3_object" "upload_env_file" {
  bucket = aws_s3_bucket.env_file_bucket.id
  key    = var.env_file_name
  source = "./${var.env_file_name}"
}
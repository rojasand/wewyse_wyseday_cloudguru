output "S3_Website_Endpoint" {
  value = aws_s3_bucket_website_configuration.myBucketWebsite.website_endpoint
}
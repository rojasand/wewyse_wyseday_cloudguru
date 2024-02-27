variable "region" {
  default = "us-east-1"
}

provider "aws" {
  region     = var.region
}

resource "random_string" "random" {
  length = 6
  special = false
  upper = false
} 

resource "aws_s3_bucket" "myBucket" {
  bucket = "wyseday-${random_string.random.result}"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "myBucketOwnership" {
  bucket = aws_s3_bucket.myBucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "myBucketAccessBlock" {
  bucket                  = aws_s3_bucket.myBucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "myBucketACL" {
  depends_on = [
    aws_s3_bucket_ownership_controls.myBucketOwnership,
    aws_s3_bucket_public_access_block.myBucketAccessBlock
  ]
  bucket = aws_s3_bucket.myBucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "indexHtml" {
  bucket       = aws_s3_bucket.myBucket.id
  key          = "index.html"
  source       = "../source/static_website/index.html"
  content_type = "text/html"
  etag = filemd5("../source/static_website/index.html")
}

resource "aws_s3_object" "errorHtml" {
  bucket       = aws_s3_bucket.myBucket.id
  key          = "error.html"
  source       = "../source/static_website/error.html"
  content_type = "text/html"
  etag = filemd5("../source/static_website/error.html")
}

resource "aws_s3_bucket_website_configuration" "myBucketWebsite" {
  bucket = aws_s3_bucket.myBucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "myBucketPolicy" {
  bucket = aws_s3_bucket.myBucket.id
  policy = <<POLICY
  {
  "Id": "Policy",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.myBucket.bucket}/*",
      "Principal": {
        "AWS": [
          "*"
        ]
      }
    }
  ]
}
  POLICY
}


provider "aws" {
  region = "us-east-1"
}

# S3 Bucket
resource "aws_s3-bucket" "nextjs_bucket" {
  bucket = "nextjs-portfolio-bucket-rp"
}

# Ownership Control
resource "aws_s3_bucket_ownership_controls" "nextjs_bucket_ownership_controls" {
  bucket = aws_s3_bucket.nextjs_bucket.id
  rule {
    object_ownership = "BucketOwnerPreffered"
  }
}

# Block public Access
resource "aws_s3_bucket_public_access_block" "nextjs_bucket_public_access_block" {
  bucket = aws_s3_bucket.nextjs_bucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

# Bucket ACL
resource "aws_s3_bucket_acl" "nextjs_bucket_acl" {
  
  depends_on = [
    aws_s3_bucket_ownership_controls.nextjs,
    aws_s3_bucket_public_access_block.nextjs_bucket_public_access_block
  ]

  bucket = aws_s3_bucketnextjs_bucket.id
  acl = "public-read"
}

# bucket policy
resource "aws_s3_bucket_policy" "nextjs_bucket_policy" {
  bucket = aws_s3_bucket.nextjs_bucket.id

  policy = jsondecode(({
    version = "2012-10-17"
    statement = [
        {
            Sid = "PublicReadGetObject"
            Effect = "Allow"
            Principal = "*"
            Action = "s3:GetObject"
            Resource = "${aws_s3_bucket.nextjs_bucket.arn}/*"
        }
    ]

  }))
}

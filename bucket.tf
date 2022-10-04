resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "wordpressS3" {
  bucket = aws_s3_bucket.b.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.b.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "Policy1664879942248",
    "Statement": [
        {
            "Sid": "Stmt1664879933992",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
})
}


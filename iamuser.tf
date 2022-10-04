resource "aws_iam_user" "my_iam_user" {
  name = "my_iam_user"
  tags = {
    Name = "iamuser"
  }
}


resource "aws_iam_access_key" "my_iam_access_key" {
  user = aws_iam_user.my_iam_user.name
}

#secretkey = aws_iam_access_key.my_iam_access_key.encrypted_secret


output "secretKey" {
  value = aws_iam_access_key.my_iam_access_key.encrypted_secret
}

# resource "aws_iam_user_policy" "s3_policy" {
#   name = "s3_policy"
#   user = aws_iam_user.my_iam_user.name

#   policy = jsonencode({
#    "Version":"2012-10-17",
#    "Statement":[
#       {
#          "Effect":"Allow",
#          "Action":["s3:ListBucket","s3:GetBucketLocation"],
#          "Resource":"arn:aws:s3:::*"
#       },
#       {
#          "Effect":"Allow",
#          "Action":[
#             "s3:PutObject",
#             "s3:GetObject",
#             "s3:DeleteObject"
#          ],
#          "Resource":"arn:aws:s3:::*/*"
#       }
#    ]
# })
# }

resource "aws_iam_user_policy" "s3_policy" {
  name = "s3_policy"
  user = aws_iam_user.my_iam_user.name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketPublicAccessBlock",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutBucketOwnershipControls",
                "s3:ListBucket",
                "s3:GetBucketAcl",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:PutBucketAcl",
                "s3:GetBucketOwnershipControls",
                "s3:DeleteObject",
                "s3:GetBucketLocation",
                "s3:PutObjectAcl"],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
})
}


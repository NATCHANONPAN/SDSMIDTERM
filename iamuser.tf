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

resource "aws_iam_user_policy" "s3_policy" {
  name = "s3_policy"
  user = aws_iam_user.my_iam_user.name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
  })
}



# resource "aws_iam_user" "iam_user" {
#     name = "natchanon"
# }

# resource "aws_iam_access_key" "iam_access_key" {
#     user = aws_iam_user.iam_user.name
# }

# resource "aws_iam_user_policy_attachment" "ec2-user-full" {
#     user = aws_iam_user.iam_user.name
#     policy_arn = aws_iam_policy.ec2-full.arn
# }

# resource "aws_iam_user_policy_attachment" "s3-user-full" {
#     user = aws_iam_user.iam_user.name
#     policy_arn = aws_iam_policy.s3-full.arn
# }
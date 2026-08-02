resource "aws_iam_role" "myajay_iam_role" {
  name               = "myajay-iam-role"
  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF  
}

resource "aws_iam_role_policy" "myajay_s3_policy" {
  name   = "myajay-s3-policy"
  role   = aws_iam_role.myajay_iam_role.id
  policy = <<EOF
{
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
}
EOF  
}

resource "aws_iam_instance_profile" "myajay_intance_profile" {
  name = "myajay-instance-policy"
  role = aws_iam_role.myajay_iam_role.id
}
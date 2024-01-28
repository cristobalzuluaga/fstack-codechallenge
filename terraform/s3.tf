resource "aws_s3_bucket" "b" {
  bucket = "fstack-cchallenge-${var.env}"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "cf_oac" {
  bucket = aws_s3_bucket.b.id
  policy = data.aws_iam_policy_document.cf_oac_data.json
}

data "aws_iam_policy_document" "cf_oac_data" {
  statement {
    sid = "CloudfrontOAC"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [ "s3:GetObject" ]
    resources = [ "arn:aws:s3:::fstack-cchallenge-${var.env}/*" ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values = [ "arn:aws:cloudfront::612061957948:distribution/${aws_cloudfront_distribution.s3_distribution.id}" ]
    }
  }
}

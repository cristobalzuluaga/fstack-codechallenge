output "bucket_name" {
  value = aws_s3_bucket.b.id
}

output "cf_dist" {
  value = aws_cloudfront_distribution.s3_distribution.id
}

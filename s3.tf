resource "aws_s3_bucket" "b" {
  bucket = "my-bucket-omar-hamdaa"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
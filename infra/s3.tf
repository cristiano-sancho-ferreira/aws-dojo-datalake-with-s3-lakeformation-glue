# HCL - Hashicorp Configuration Language
# Linguagem declarativa

resource "aws_s3_bucket" "lake_raw" {
  # Parametros de configuracao do recurso escolhido
  bucket = var.bucket_raw_data
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    "projeto" = var.tag_project
  }
}


resource "aws_s3_bucket_object" "customers" {
  bucket = aws_s3_bucket.lake_raw.id
  key    = "customers/customers.csv"
  acl    = "private"
  source = "../data/customers.csv"
  etag   = filemd5("../data/customers.csv")
}

resource "aws_s3_bucket_object" "sales" {
  bucket = aws_s3_bucket.lake_raw.id
  key    = "sales/sales.csv"
  acl    = "private"
  source = "../data/sales.csv"
  etag   = filemd5("../data/sales.csv")
}

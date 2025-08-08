resource "aws_dynamodb_table" "v_regions" {
  name           = "v_regions"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "pk"
  range_key      = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  tags = {
    Environment = "dev"
    Name        = "v_regions"
  }
}
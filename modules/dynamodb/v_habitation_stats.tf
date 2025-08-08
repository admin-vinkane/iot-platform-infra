resource "aws_dynamodb_table" "v_habitation_stats" {
  name           = "v_habitation_stats"
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

  # Optional: GSI to fetch latest record per habitation
  global_secondary_index {
    name               = "GSI1"
    hash_key           = "pk"
    range_key          = "sk"
    projection_type    = "ALL"
  }

  tags = {
    Environment = "dev"
    Project     = "iot-regions"
  }
}

resource "aws_dynamodb_table" "v_districts" {
  name           = "v_districts"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "district_id"

  attribute {
    name = "district_id"
    type = "S"
  }

  attribute {
    name = "state_id"
    type = "S"
  }

  attribute {
    name = "district_code"
    type = "S"
  }

  attribute {
    name = "district_name"
    type = "S"
  }

  attribute {
    name = "display_name"
    type = "S"
  }

  attribute {
    name = "createdbyuser"
    type = "S"
  }

  attribute {
    name = "created_date"
    type = "S"
  }

  attribute {
    name = "modifiedbyuser"
    type = "S"
  }

  attribute {
    name = "updated_date"
    type = "S"
  }
}

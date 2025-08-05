resource "aws_dynamodb_table" "v_states" {
  name           = "v_states"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "state_id"

  attribute {
    name = "state_id"
    type = "S"
  }

  attribute {
    name = "state_code"
    type = "S"
  }

  attribute {
    name = "state_name"
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

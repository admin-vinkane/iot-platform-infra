resource "aws_dynamodb_table" "v_villages" {
  name           = "v_villages"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "village_id"

  attribute {
    name = "village_id"
    type = "S"
  }

  attribute {
    name = "mandal_id"
    type = "S"
  }

  attribute {
    name = "district_id"
    type = "S"
  }

  attribute {
    name = "state_id"
    type = "S"
  }

  attribute {
    name = "village_code"
    type = "S"
  }

  attribute {
    name = "village_name"
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

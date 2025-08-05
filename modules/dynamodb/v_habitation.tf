resource "aws_dynamodb_table" "v_habitation" {
  name           = "v_habitation"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "habitation_id"

  attribute {
    name = "habitation_id"
    type = "S"
  }

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
    name = "habitation_code"
    type = "S"
  }

  attribute {
    name = "habitation_name"
    type = "S"
  }

  attribute {
    name = "display_name"
    type = "S"
  }

  attribute {
    name = "capacity"
    type = "N"
  }

  attribute {
    name = "motor_capacity"
    type = "N"
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

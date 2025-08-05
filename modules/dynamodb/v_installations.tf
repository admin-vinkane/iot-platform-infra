resource "aws_dynamodb_table" "v_installations" {
  name           = "v_installations"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "installation_id"

  attribute {
    name = "installation_id"
    type = "S"
  }

  attribute {
    name = "habitation_id"
    type = "S"
  }

  attribute {
    name = "installation_code"
    type = "S"
  }

  attribute {
    name = "installed_date"
    type = "S"
  }

  attribute {
    name = "tank_link_device_reg_id"
    type = "S"
  }

  attribute {
    name = "chlorine_link_device_reg_id"
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

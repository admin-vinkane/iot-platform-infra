resource "aws_dynamodb_table" "v_installed_device_registration_usage" {
  name           = "v_installed_device_registration_usage"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "device_reg_usage_id"

  attribute {
    name = "device_reg_usage_id"
    type = "S"
  }

  attribute {
    name = "device_reg_id"
    type = "S"
  }

  attribute {
    name = "installation_id"
    type = "S"
  }

  attribute {
    name = "qty"
    type = "N"
  }

  attribute {
    name = "ppm_value"
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

resource "aws_dynamodb_table" "v_device_registrations" {
  name           = "v_device_registrations"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "device_reg_id"

  attribute {
    name = "device_reg_id"
    type = "S"
  }

  attribute {
    name = "device_id"
    type = "S"
  }

  attribute {
    name = "device_name"
    type = "S"
  }

  attribute {
    name = "serial_number"
    type = "S"
  }

  attribute {
    name = "device_mobile_number"
    type = "S"
  }

  attribute {
    name = "user_mobile_number"
    type = "S"
  }

  attribute {
    name = "start_datetime"
    type = "S"
  }

  attribute {
    name = "end_datetime"
    type = "S"
  }

  attribute {
    name = "status"
    type = "S"
  }

  attribute {
    name = "power_status"
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

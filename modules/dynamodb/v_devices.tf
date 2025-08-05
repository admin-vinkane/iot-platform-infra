resource "aws_dynamodb_table" "v_devices" {
  name           = "v_devices"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "device_id"

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
    name = "device_type"
    type = "S"
  }

  attribute {
    name = "status"
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

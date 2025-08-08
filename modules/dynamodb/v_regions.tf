# aws_dynamodb_table.v_regions:
resource "aws_dynamodb_table" "v_regions" {
    # arn                         = "arn:aws:dynamodb:ap-south-2:336300525343:table/v_regions"
    billing_mode                = "PAY_PER_REQUEST"
    deletion_protection_enabled = false
    hash_key                    = "pk"
    #id                          = "v_regions"
    name                        = "v_regions"
    range_key                   = "sk"
    read_capacity               = 0
    region                      = "ap-south-2"
    stream_arn                  = null
    stream_enabled              = false
    stream_label                = null
    stream_view_type            = null
    table_class                 = "STANDARD"
    tags                        = {}
    tags_all                    = {}
    write_capacity              = 0

    attribute {
        name = "pk"
        type = "S"
    }
    attribute {
        name = "sk"
        type = "S"
    }

    point_in_time_recovery {
        enabled                 = false
        recovery_period_in_days = 7
    }

    ttl {
        attribute_name = null
        enabled        = false
    }
}

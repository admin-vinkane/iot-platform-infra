
resource "aws_apigatewayv2_api" "iot_api" {
  name          = "iot-api"
  protocol_type = "HTTP"
}

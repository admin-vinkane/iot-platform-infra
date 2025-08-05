
resource "aws_lambda_function" "v_mandals_read" {
  function_name = "v_mandals_read"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "read.lambda_handler"
  runtime       = "python3.12"
  filename      = "../../backend/lambdas/v_mandals/read.zip"
  source_code_hash = filebase64sha256("../../backend/lambdas/v_mandals/read.zip")
}

resource "aws_apigatewayv2_integration" "v_mandals_read_integration" {
  api_id           = aws_apigatewayv2_api.iot_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.v_mandals_read.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "v_mandals_read_route" {
  api_id    = aws_apigatewayv2_api.iot_api.id
  route_key = "POST /v_mandals/read"
  target    = "integrations/${aws_apigatewayv2_integration.v_mandals_read_integration.id}"
}

resource "aws_lambda_permission" "v_mandals_read_permission" {
  statement_id  = "AllowAPIGatewayInvoke_v_mandals_read"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.v_mandals_read.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.iot_api.execution_arn}/*/*"
}

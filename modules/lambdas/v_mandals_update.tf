
resource "aws_lambda_function" "v_mandals_update" {
  function_name = "v_mandals_update"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "update.lambda_handler"
  runtime       = "python3.12"
  filename      = "../../backend/lambdas/v_mandals/update.zip"
  source_code_hash = filebase64sha256("../../backend/lambdas/v_mandals/update.zip")
}

resource "aws_apigatewayv2_integration" "v_mandals_update_integration" {
  api_id           = aws_apigatewayv2_api.iot_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.v_mandals_update.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "v_mandals_update_route" {
  api_id    = aws_apigatewayv2_api.iot_api.id
  route_key = "POST /v_mandals/update"
  target    = "integrations/${aws_apigatewayv2_integration.v_mandals_update_integration.id}"
}

resource "aws_lambda_permission" "v_mandals_update_permission" {
  statement_id  = "AllowAPIGatewayInvoke_v_mandals_update"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.v_mandals_update.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.iot_api.execution_arn}/*/*"
}

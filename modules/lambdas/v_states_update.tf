
resource "aws_lambda_function" "v_states_update" {
  function_name = "v_states_update"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "update.lambda_handler"
  runtime       = "python3.12"
  filename      = "../../backend/lambdas/v_states/update.zip"
  source_code_hash = filebase64sha256("../../backend/lambdas/v_states/update.zip")
}

resource "aws_apigatewayv2_integration" "v_states_update_integration" {
  api_id           = aws_apigatewayv2_api.iot_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.v_states_update.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "v_states_update_route" {
  api_id    = aws_apigatewayv2_api.iot_api.id
  route_key = "POST /v_states/update"
  target    = "integrations/${aws_apigatewayv2_integration.v_states_update_integration.id}"
}

resource "aws_lambda_permission" "v_states_update_permission" {
  statement_id  = "AllowAPIGatewayInvoke_v_states_update"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.v_states_update.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.iot_api.execution_arn}/*/*"
}

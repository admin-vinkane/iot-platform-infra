
resource "aws_lambda_function" "v_installations_delete" {
  function_name = "v_installations_delete"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "delete.lambda_handler"
  runtime       = "python3.12"
  filename      = "../../backend/lambdas/v_installations/delete.zip"
  source_code_hash = filebase64sha256("../../backend/lambdas/v_installations/delete.zip")
}

resource "aws_apigatewayv2_integration" "v_installations_delete_integration" {
  api_id           = aws_apigatewayv2_api.iot_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.v_installations_delete.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "v_installations_delete_route" {
  api_id    = aws_apigatewayv2_api.iot_api.id
  route_key = "POST /v_installations/delete"
  target    = "integrations/${aws_apigatewayv2_integration.v_installations_delete_integration.id}"
}

resource "aws_lambda_permission" "v_installations_delete_permission" {
  statement_id  = "AllowAPIGatewayInvoke_v_installations_delete"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.v_installations_delete.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.iot_api.execution_arn}/*/*"
}

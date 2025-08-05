
resource "aws_lambda_function" "v_districts_create" {
  function_name = "v_districts_create"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "create.lambda_handler"
  runtime       = "python3.12"
  filename      = "../../backend/lambdas/v_districts/create.zip"
  source_code_hash = filebase64sha256("../../backend/lambdas/v_districts/create.zip")
}

resource "aws_apigatewayv2_integration" "v_districts_create_integration" {
  api_id           = aws_apigatewayv2_api.iot_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.v_districts_create.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "v_districts_create_route" {
  api_id    = aws_apigatewayv2_api.iot_api.id
  route_key = "POST /v_districts/create"
  target    = "integrations/${aws_apigatewayv2_integration.v_districts_create_integration.id}"
}

resource "aws_lambda_permission" "v_districts_create_permission" {
  statement_id  = "AllowAPIGatewayInvoke_v_districts_create"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.v_districts_create.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.iot_api.execution_arn}/*/*"
}

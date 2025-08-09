resource "aws_iam_role" "v_regions_lambda_role" {
  name = "v_regions_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "v_regions_lambda_policy" {
  name = "v_regions_lambda_policy"
  role = aws_iam_role.v_regions_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query"
        ]
        Resource = module.dynamodb.aws_dynamodb_table.v_regions.arn
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "v_regions_api" {
  filename         = "${path.module}/v_regions_api.zip"
  function_name    = "v_regions_api"
  role             = aws_iam_role.v_regions_lambda_role.arn
  handler          = "v_regions_api.lambda_handler"
  runtime          = "python3.12"
  timeout          = 10
  environment {
    variables = {
      TABLE_NAME = module.dynamodb.aws_dynamodb_table.v_regions.name
    }
  }
  source_code_hash = filebase64sha256("${path.module}/v_regions_api.zip")
}

resource "aws_apigatewayv2_api" "v_regions_api" {
  name          = "v_regions_api"
  protocol_type = "HTTP"
}

resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.v_regions_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.v_regions_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "v_regions_lambda" {
  api_id                 = aws_apigatewayv2_api.v_regions_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.v_regions_api.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "v_regions_routes" {
  for_each = {
    "POST /regions"             = { route_key = "POST /regions" }
    "GET /regions/{pk}/{sk}"    = { route_key = "GET /regions/{pk}/{sk}" }
    "GET /regions"              = { route_key = "GET /regions" }
    "PUT /regions/{pk}/{sk}"    = { route_key = "PUT /regions/{pk}/{sk}" }
    "DELETE /regions/{pk}/{sk}" = { route_key = "DELETE /regions/{pk}/{sk}" }
  }
  api_id    = aws_apigatewayv2_api.v_regions_api.id
  route_key = each.value.route_key
  target    = "integrations/${aws_apigatewayv2_integration.v_regions_lambda.id}"
}

resource "aws_apigatewayv2_stage" "v_regions_stage" {
  api_id      = aws_apigatewayv2_api.v_regions_api.id
  name        = "$default"
  auto_deploy = true
}
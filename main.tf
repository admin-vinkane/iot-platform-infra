
module "dynamodb_tables" {
  source = "./modules/dynamodb"
}

module "lambda_functions" {
  source = "./modules/lambdas"
}

module "api_gateway" {
  source = "./modules/api"
}

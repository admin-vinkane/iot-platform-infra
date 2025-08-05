
# IoT Platform Infrastructure (Terraform)

This repository defines the complete infrastructure setup for the IoT Device Management Platform using Terraform on AWS.

## Components

- **DynamoDB**: 10 tables to store hierarchical and relational IoT data
- **Lambda Functions**: Python-based CRUD handlers
- **IAM Roles and Policies**: For Lambda execution
- **API Gateway**: HTTP API to expose Lambda endpoints

## Structure

- `main.tf`: Root module integrating all components
- `variables.tf`: Input variables
- `outputs.tf`: API Gateway output
- `modules/dynamodb/`: DynamoDB table definitions
- `modules/lambdas/`: Lambda definitions and IAM setup
- `modules/api/`: API Gateway integrations and routes

## Deployment

```bash
terraform init
terraform plan
terraform apply
```

Ensure you have your AWS credentials configured before running.

## Notes

- Lambda source code should be pre-packaged and referenced by zip paths
- Adjust file paths if deploying in a different structure

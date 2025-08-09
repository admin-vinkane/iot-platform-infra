import boto3

dynamodb = boto3.client('dynamodb', region_name='ap-south-2')

def describe_table():
    table_name = 'v_habitation_stats'  # Replace with your table name
    response = dynamodb.describe_table(TableName=table_name)
    schema = response['Table']['KeySchema']
    print("Key Schema:", [{'AttributeName': 'pk', 'KeyType': 'HASH'}, {'AttributeName': 'sk', 'KeyType': 'RANGE'}])

if __name__ == '__main__':
    describe_table()

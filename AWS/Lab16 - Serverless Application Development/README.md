# Lab 16 - Serverless Application Development

## **Objective**

### Build a serverless application using AWS Lambda, API Gateway, and DynamoDB
This tutorial demonstrates how to create a serverless API for performing CRUD (Create, Read, Update, Delete) operations on a DynamoDB table. The API is built using AWS Lambda for backend logic and API Gateway for routing HTTP requests.
![image](https://github.com/user-attachments/assets/4e491ea1-7691-41f8-96eb-fda85fe9bb5c)

### **Steps:**

#### 1. Create a DynamoDB Table
Store items with a unique `id` as the partition key.
![image](https://github.com/user-attachments/assets/739f26ab-2e6c-4972-a2c3-f557f557fc53)

#### 2. Create a Lambda Function
Backend logic for CRUD operations on the DynamoDB table.
![image](https://github.com/user-attachments/assets/8c78a963-c6d0-4c23-8725-713265af81be)

Code
```
import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  ScanCommand,
  PutCommand,
  GetCommand,
  DeleteCommand,
} from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "http-crud-tutorial-items";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "DELETE /items/{id}":
        await dynamo.send(
          new DeleteCommand({
            TableName: tableName,
            Key: {
              id: event.pathParameters.id,
            },
          })
        );
        body = `Deleted item ${event.pathParameters.id}`;
        break;
      case "GET /items/{id}":
        body = await dynamo.send(
          new GetCommand({
            TableName: tableName,
            Key: {
              id: event.pathParameters.id,
            },
          })
        );
        body = body.Item;
        break;
      case "GET /items":
        body = await dynamo.send(
          new ScanCommand({ TableName: tableName })
        );
        body = body.Items;
        break;
      case "PUT /items":
        let requestJSON = JSON.parse(event.body);
        await dynamo.send(
          new PutCommand({
            TableName: tableName,
            Item: {
              id: requestJSON.id,
              price: requestJSON.price,
              name: requestJSON.name,
            },
          })
        );
        body = `Put item ${requestJSON.id}`;
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers,
  };
};

```
![image](https://github.com/user-attachments/assets/827fe125-ebdd-4bce-a0d1-14a7cb679071)

#### 3. Create an HTTP API (API Gateway)
Define API routes and integrate them with the Lambda function.
![image](https://github.com/user-attachments/assets/362fde8a-a2b9-4bfe-9f21-b64b36c9a160)

#### 4. Configure Routes
Configure Routes:

Set up paths for:
- `GET /items` - Retrieve all items.
- `GET /items/{id}` - Retrieve a specific item.
- `PUT /items` - Add a new item.
- `DELETE /items/{id}` - Delete a specific item.
  
![image](https://github.com/user-attachments/assets/4281fe67-11d1-4d16-a8d9-b5d0ae607d2f)

#### 5. Create Integrations
Connect API routes to the Lambda function
![image](https://github.com/user-attachments/assets/60515b89-9086-4987-aa8c-e86b3fb28ab7)

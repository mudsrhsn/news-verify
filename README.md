# NewsVerify

## Overview

NewsVerify is an Azure-based application designed to detect and verify fake news using AI/ML algorithms. It leverages Azure Functions for processing, Cosmos DB for storage, and Application Insights for monitoring.

## Architecture

The initial deployment includes the following mandatory resources:

- **Azure Resource Group** – Organizes all resources.
- **Azure Storage Account** – Stores Terraform state files.
- **Azure Function App** – Hosts the core verification logic.
- **Azure Cosmos DB** – Stores news verification data.
- **Azure Application Insights** – Monitors app performance.

## Development Stack

- **Infrastructure as Code (IaC):** Terraform
- **Cloud Provider:** Microsoft Azure
- **Backend:** Python (Azure Functions)
- **Database:** Cosmos DB
- **Monitoring:** Application Insights

## Future Enhancements

Depending on future requirements, additional Azure services can be integrated to enhance performance, security, scalability, and efficiency. Features like caching, secret management, networking improvements, or containerization may be considered as the application evolves.

## License

This project is licensed under the MIT License.

hybrid-cloud
---

# About
AWS, GCP, Azureのハイブリッドクラウドのテスト

# Components
## App
* Laravel
* nginx

## AWS
* Amazon Elastic Container Service
    - Fargate Mode

## GCP
* Google Kubernetes Engine

## Azure
* Azure Kubernetes Service

## Other
* DockerHub
* Datadog

# Deploy
## GCP
```
$ kubectl create secret generic dd-agent --from-literal=api-key=<YOUR DATADOG API KEY>
```

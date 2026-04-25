# aks-gitops-platform
# 🚀 Azure Enterprise AKS GitOps Platform

## 📌 Overview

This repository demonstrates a **production-style, enterprise-grade Azure Kubernetes platform** built using modern cloud-native practices.
It showcases how to design, deploy, and manage scalable and secure infrastructure using **Terraform, Helm, and GitOps (ArgoCD)** across a **multi-subscription Azure architecture**.

---

## 🧱 Architecture

### 🌐 High-Level Design

* **Platform Subscription (Shared Services)**

  * Azure Container Registry (ACR)
  * Azure Key Vault
  * Hub Virtual Network

* **Dev Subscription (Workload)**

  * Azure Kubernetes Service (AKS)
  * Spoke Virtual Network
  * Application workloads

* **Networking**

  * Hub-Spoke topology
  * VNet peering between Platform and Dev

---

## 🛠️ Tech Stack

| Layer         | Technology                              |
| ------------- | --------------------------------------- |
| Cloud         | Microsoft Azure                         |
| Compute       | Azure Kubernetes Service (AKS)          |
| IaC           | Terraform                               |
| CI/CD         | GitHub Actions                          |
| GitOps        | ArgoCD                                  |
| Packaging     | Helm                                    |
| Security      | Azure Key Vault, Managed Identity, RBAC |
| Networking    | VNet, Subnets, Peering                  |
| Observability | Azure Monitor, Prometheus (optional)    |
| Service Mesh  | Istio (planned)                         |

---

## 📁 Repository Structure

```bash
aks-gitops-platform/
├── terraform/
│   ├── modules/
│   └── envs/
│       ├── platform/
│       └── dev/
├── helm/
│   └── sample-api/
├── k8s/
│   └── dev/
├── argocd/
├── istio/
├── pipelines/
└── README.md
```

---

## ⚙️ Key Features

* ✅ Multi-subscription Azure architecture (Platform + Dev)
* ✅ Infrastructure provisioning using Terraform modules
* ✅ AKS cluster deployment with secure networking
* ✅ Container image management via ACR
* ✅ Helm-based Kubernetes application packaging
* ✅ GitOps deployment using ArgoCD
* ✅ Secure secrets management with Azure Key Vault
* ✅ Managed Identity and RBAC integration
* ✅ Hub-Spoke network topology
* ✅ Designed for scalability, security, and high availability

---

## 🔐 Security Design

* Azure Key Vault for secrets and encryption
* Managed Identity for secure service-to-service communication
* Role-Based Access Control (RBAC)
* Private networking with VNet isolation
* (Planned) mTLS using Istio Service Mesh

---

## 🔄 CI/CD & GitOps Flow

1. Developer commits code to GitHub
2. GitHub Actions builds Docker image
3. Image pushed to Azure Container Registry (ACR)
4. Git repo updated with new image tag
5. ArgoCD detects change and deploys to AKS

---

## 🚀 Getting Started

### Prerequisites

* Azure Subscription(s)
* Azure CLI
* Terraform
* kubectl
* Helm

---

### Deploy Infrastructure

```bash
cd terraform/envs/platform
terraform init
terraform apply

cd ../dev
terraform init
terraform apply
```

---

### Connect to AKS

```bash
az aks get-credentials --name <aks-name> --resource-group <rg-name>
kubectl get nodes
```

---

### Deploy Application (Helm)

```bash
cd helm/sample-api
helm install sample-app .
```

---

## 📈 Future Enhancements

* 🔹 Istio Service Mesh (mTLS, traffic routing)
* 🔹 Azure DevOps pipeline integration
* 🔹 Multi-environment (Test/Prod) expansion
* 🔹 Advanced monitoring with Grafana dashboards
* 🔹 Policy enforcement using Azure Policy / OPA

---

## 🎤 Interview Talking Points

* Designed **multi-subscription architecture** for separation of concerns
* Implemented **Infrastructure as Code using Terraform**
* Used **Helm for application packaging**
* Applied **GitOps principles with ArgoCD**
* Integrated **Azure-native security (Key Vault, Managed Identity)**
* Built **scalable, resilient AKS platform aligned with enterprise best practices**

---

## 📬 Contact

Feel free to connect or reach out for discussions on cloud architecture, DevOps, and Kubernetes.

---

# AWS CI Pipeline & Docker Deployment for Java Application

## 📋 Project Overview
This project demonstrates an **Automated Continuous Integration (CI)** pipeline for a Java Spring Boot application. The goal was to automate the build and containerization process using **AWS CodeBuild** and securely store artifacts in **Amazon ECR**. The final deployment is managed manually on an **Amazon EC2** instance using Docker commands.

## 🏗️ Architecture
**GitHub** (Source Code) ➔ **AWS CodeBuild** (Build & Package) ➔ **Amazon ECR** (Image Storage) ➔ **Amazon EC2** (Production Server)

---

## 🛠️ Tech Stack
* **Cloud Platform:** AWS (Amazon Web Services)
* **CI Service:** AWS CodeBuild
* **Container Registry:** Amazon ECR (Elastic Container Registry)
* **Compute:** Amazon EC2 (Ubuntu 24.04 LTS)
* **Containerization:** Docker
* **Build Tool:** Apache Maven
* **Language:** Java 17

---

## ⚙️ Implementation Steps

### Phase 1: Infrastructure Setup
1.  **ECR Repository:** Created a private repository named `uday-ecr`.
2.  **IAM Roles:**
    * **CodeBuild Role:** Attached `AmazonEC2ContainerRegistryPowerUser` (Allows pushing images).
    * **EC2 Role:** Attached `AmazonEC2ContainerRegistryReadOnly` (Allows pulling images).
3.  **Security Groups:** Configured EC2 to allow inbound traffic on **Port 80 (HTTP)** and **Port 22 (SSH)** via `0.0.0.0/0`.

### Phase 2: Continuous Integration (AWS CodeBuild)
Configured CodeBuild to automate the build pipeline. It performs the following steps automatically:
* **Login:** Authenticates with AWS ECR.
* **Build:** Compiles the Java source code using Maven.
* **Image Creation:** Builds a Docker image from the generated JAR file.
* **Push:** Tags and pushes the final image to the private ECR repository.

### Phase 3: Deployment on EC2 (Manual)
Launched an Ubuntu EC2 instance and performed the following setup and deployment manually.

#### 1. Server Setup Script
Ran the following commands to prepare the server and install dependencies:

```bash
# Update System
sudo apt update

# Install Docker and AWS CLI
sudo apt install docker.io awscli -y

# Start Docker Service
sudo systemctl start docker

# Add User to Docker Group (To run docker without sudo)
sudo usermod -aG docker ubuntu

#Application Deployment
Used the following commands to pull the latest image from ECR and run the container (mapping Port 80 to 8080):

# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin AWSID.dkr.ecr.ap-south-1.amazonaws.com

# Run Container
docker run -d -p 80:8080 [082972943693.dkr.ecr.ap-south-1.amazonaws.com/uday-ecr:latest](https://AWSID.dkr.ecr.ap-south-1.amazonaws.com/uday-ecr:latest)

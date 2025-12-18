
# 🚀 Strapi Deployment on AWS EC2 using Docker & Terraform

This project demonstrates a complete DevOps workflow where a **Strapi CMS application** is:

- Containerized using **Docker**
- Published to **Docker Hub**
- Provisioned on **AWS EC2** using **Terraform**
- Automatically installed and launched using EC2 **user_data**
- Fully accessible over the internet via the EC2 **public IP + port 1337**

This showcases automation, cloud infrastructure, containerization, and real-world deployment skills.

---

## 📌 Project Architecture

```

Local Machine (Build + Push Image)
↓
Docker Hub (Stores Strapi Image)
↓
Terraform (Infra Provisioning)
↓
AWS EC2 Instance (Amazon Linux 2023)
↓
User Data Script (Installs Docker + Runs Strapi)
↓
Strapi Live at: http://<EC2_PUBLIC_IP>:1337

````

---

## 🧩 **1. Dockerization of Strapi**

A custom `Dockerfile` was created to containerize the Strapi application:

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

ENV HOST=0.0.0.0
ENV PORT=1337

EXPOSE 1337

CMD ["npm", "start"]
````

### Steps Performed:

* Built Docker image locally
* Tagged image: `lovepreetsingh3028/pt-strapi-app-task5:latest`
* Pushed to Docker Hub using Docker Desktop

---

## 🏗 **2. Terraform Infrastructure Provisioning**

A dedicated Terraform setup was created with the following structure:

```
terraform/
│── main.tf
│── variables.tf
│── outputs.tf
└── user_data.sh
```

### Terraform Responsible For:

* Creating a **Security Group**
* Creating an **EC2 Key Pair**
* Launching an **EC2 Instance (t2.micro)**
* Passing `user_data.sh` to automatically install Docker and run your Strapi container
* Outputting the **public IP** of the EC2 instance

---

## ⚙️ **3. user_data.sh (Automation Script)**

This script automatically runs on instance launch:

```bash
#!/bin/bash

sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Pull and run Strapi Docker Container
sudo docker pull lovepreetsingh3028/pt-strapi-app-task5:latest

sudo docker run -d \
  -p 1337:1337 \
  --name strapi \
  -e HOST=0.0.0.0 \
  lovepreetsingh3028/pt-strapi-app-task5:latest
```

---

## ☁️ **4. Deploying Using Terraform**

Inside the `terraform/` directory, the following commands were executed:

```sh
terraform init
terraform plan
terraform apply -auto-approve
```

Once complete, Terraform outputs:

```
ec2_public_ip = "<PUBLIC_IP>"
```

---

## 🌐 **5. Accessing Strapi**

Once EC2 is launched successfully:

Open your browser:

```
http://<EC2_PUBLIC_IP>:1337
```

You will reach the **Strapi Admin Panel**.

Example:

```
http://13.201.188.2:1337
```

Strapi is served directly from your Docker container running on EC2.

---

## 🔐 **6. SSH Into EC2 (Optional)**

SSH command used:

```sh
ssh -i ~/.ssh/id_rsa ec2-user@<EC2_PUBLIC_IP>
```

To verify the container:

```sh
docker ps
```

Expected:

```
strapi running on port 1337
```

---

## 🎯 **What This Project Demonstrates**

✔ Cloud deployment using Infrastructure-as-Code
✔ Docker containerization of a Node.js CMS
✔ Pushing and using images from Docker Hub
✔ Automated provisioning with Terraform
✔ Running Strapi in a production-like environment
✔ Understanding of ports, security groups, EC2 networking
✔ Real DevOps workflow end-to-end

---

## 🚀 **Future Enhancements**

* Use AWS ECR instead of Docker Hub
* Deploy using ECS Fargate instead of EC2
* Add an Nginx reverse proxy + HTTPS
* Use Route53 for custom domain
* Store uploads in S3
* Enable autoscaling via ASG & ALB

---

## 💬 Author

**Lovepreet Singh**
DevOps Enthusiast | Docker | Terraform | AWS

---

## ⭐ If you like this project, give it a star on GitHub!

```



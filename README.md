
# Welcome to our DevOps-Project 

## Introduction to DevOps

This Repo is build on our DevOps-Project based on the Datascientest Training for DevOps.
You will find a Pipeline using different tools to run an App on a bare-metal Server.

DevOps is the art of automation. 
It combines the development of new features and bugfixes with the operation of infrastucture to deploy on the Server or Cloud as well as keeping configurations updated, maintanance and scaling.
Combining these two main departments brings several benefits:

- Infrastructure as Code minimizes sources of errors.
- Greatly shortens the time from develop to deploy the applications.
- Testing given and new code is within the automation.
- Keep data and configurations safe due to automated backups.
- Get notifications of warnings and errors directly and available for the entire team.

The Pipeline of DevOps is also known as CI/CD-Pipline. "Constant Integration and Continuous Delivery" describes best the automation to gain speed and quality in deploying applications.

Tools that we have used:
- Slack for planning and communication
- GitHub for Code
- GitHub Actions to
  - Compile App and upload image
  - deploy data and Terraform to the server
- Terraform to deploy Infrastructure-As-Code
- Kubernetes (K3s) to manage orchestration and connection of the App and Monitoring
- Prometheus to monitor all Data from Server, Kubernetes, Container and App
- Alertmanager to get notifications to our Slack-channel
- Grafana to visualize the data delivered by Prometheus

## Run Application: Petclinic on a Server

Our pipeline is built around the famous Spring Petclinic [Petclinic](https://github.com/spring-projects/spring-petclinic) as a [Spring Boot](https://spring.io/guides/gs/spring-boot) application.
To run the pipeline you have to do some steps:

1. Download Repo and use it as your own Repo on GutHub
  - Create several GitHub-Actions "Secrets":
    - For connection to Sever we need the IP and Password for SSh-connection. Username is ubuntu:
      - "SSH_ALEX_SERVER_IP"
      - "SSH_ALEX_SERVER_PW"
    - To Upload the application as image we need the login to our DockerHub:
      - "DOCKERHUB_USERNAME"
      - "DOCKERHUB_TOKEN"
    - To get SSL-encrypted connection to our webserver we need the certificate and key:
      - SSL_INGRESS_SIMPLYSTU_CERT
      - SSL_INGRESS_SIMPLYSTU_KEY
    - To get notivications we need an URL to a Slack-channel. The WebHook is created by an App in Slack.
      - ALERTMANAGER_URL_SLACK
  - Change domain to your adress in the ingress-configuration at "infra/k3s/ingress-resource.yml" for example to "petclinic(-dev).<webserver>.de"

2. If we now push folder/file-dependent changes to our repo the workflows will be started:
  - Configure the basic setup and installation of needed tools:
    - .github/workflows/Server-BasicSetup.yml
  - Deploy everything configured to server: 
    - 'infra/**' |
    - 'monitoring/**' |
    - .github/workflows/Deploy-DEV.yml
  - Build the application and upload to DockerHub:
    - 'app/**' |
    - .github/workflows/Build-App.yml
    
3. Open the started applications on thise adresses:
  - Application Petclinic: your domain from config, for example "http(s)://petclinic(-dev).<Domain>.de"
  - Prometheus on Nodeport: http://<Server-IP>:30000
  - Alertmanager on Nodeport: http://<Server-IP>:31000
  - Grafana on Nodeport: http://<Server-IP>:32000

---

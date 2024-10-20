# petclinic-jul24
Combined repo for App/Infra and DEV/PROD


Updates:

2024.09.27:
- merged branch from "prod-branch-main" to "dev-branch" (Image-Version:2.0)
- app is now using docker-compose for app & database instead of dockerfile only
- created workpace "dev" in terraform
- created namespace "dev" in k3s

2024.10.10
- dev-branch 
  - petclinic service as loadbalancer running on: 
    - http://petclinic.ph-rustingheart.dns-dynamic.net:30001 with port 8080:30001/TCP
    - http://52.16.155.59:30001 with port 8080:30001/TCP
  - ingress-traefik/tls as loadbalancer on:
    - https://petclinic.ph-rustingheart.dns-dynamic.net/ with port 443:30345/TCP

- applying following .yml files:
  - /home/ubuntu/petclinic-jul24/infra/k3s/1-basic-way/petclinic-combined.yml
  - /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/ingress-traefik.yml
  - /home/ubuntu/petclinic-jul24/infra/k3s/2-with-ingress/tls-secret.yml

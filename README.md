dev-db branch 

working on integrating the mysql database on port: 3306

changes in app:

app/src/main/resources/application.properties:
not using the app/src/main/resources/db/ anymore but leading to port

app/pom.xml:
commented out dependency for h2 + postgres

changes in infra:
added two folders: 
infra/k3s/vp: app-combined.yml, ingress-combined.yml, db-combined.yml, db-config.yml
infra/k3s/secrets: db-secret.yml

loading a App-Deployment + Service, DB-Statefulset + Service, Configuring Database, Configuring Ingress as Loadbalancer

applying these Manifests on main.tf

everything else i can refer to README.md in dev-branch


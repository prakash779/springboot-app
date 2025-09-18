# Hello Boot POC (Spring Boot + Docker + Jenkins + AWS)

Minimal Spring Boot app with a `/hello` endpoint, Dockerfile, and optional Jenkins pipeline.

## 1) Prerequisites
- Java 17 (Temurin/Corretto), Maven 3.9+
- Docker
- AWS CLI v2 configured
- (Optional) Jenkins agent with Docker, Maven, AWS CLI

## 2) Build & Run Locally
```bash
mvn clean package
java -jar target/hello-boot-1.0.0.jar
# Test
curl http://localhost:8080/hello
```

## 3) Build Docker Image & Run
```bash
docker build -t hello-boot:1.0.0 .
docker run -p 8080:8080 hello-boot:1.0.0
# Test
curl http://localhost:8080/hello
```

## 4) Push Image to ECR
```bash
AWS_REGION=ap-south-1
AWS_ACCOUNT=123456789012   # CHANGE
REPO=hello-boot

aws ecr create-repository --repository-name $REPO --region $AWS_REGION || true
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com

docker tag hello-boot:1.0.0 $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:1.0.0
docker push $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:1.0.0
```

## 5) Publish Artifact to CodeArtifact (optional)
```bash
# 1) Create (one-time)
aws codeartifact create-domain --domain mydomain
aws codeartifact create-repository --domain mydomain --repository maven-releases --description "Releases"

# 2) Login (generates settings.xml with token)
aws codeartifact login --tool maven --repository maven-releases --domain mydomain --domain-owner $AWS_ACCOUNT --region $AWS_REGION

# 3) Deploy JAR to CodeArtifact
mvn -s ~/.m2/settings.xml -B deploy
```
> Update `distributionManagement` URLs in `pom.xml` first.

## 6) Jenkins
- Add the included `Jenkinsfile` to your repo.
- Configure credentials & environment variables (AWS_ACCOUNT, AWS_REGION).
- Create a pipeline job pointing to your Git repo.

## 7) Deploy (choose one)
- **EC2/Tomcat**: Build WAR variant and copy to `/webapps`
- **ECS**: Update service to new ECR image tag
- **EKS**: Update Deployment image and `kubectl apply -f deploy.yaml`

## 8) Rollback
- **Containers**: revert to previous image tag
- **JAR/WAR**: fetch previous version from CodeArtifact and redeploy

## Endpoint
```
GET /hello -> "Hello, Spring Boot from Docker!"
```

# Dockerizing Applications

## Files Included

* Dockerfile
* hello-word.txt
* app.js
* docker-build-logs.txt
* acr-push-logs.txt

## Command-Only Procedure

### Step 1: Navigate to Project Directory

```bash
cd ABB-Assignment/Task 7 -Dockerizing Applications/my-app
```

### Step 2: Build Docker Image

```bash
docker build -t dockerized-app:1.0 .
```

### Step 3: Run Docker Container Locally

```bash
docker run -p 3000:3000 dockerized-app:1.0
```

### Step 4: Log in to Azure

```bash
az login
```

### Step 5: Log in to ACR

```bash
az acr login --name mydockeracr
```

### Step 6: Tag Docker Image for ACR

```bash
docker tag dockerized-app:1.0 mydockeracr.azurecr.io/dockerized-app:1.0
```

### Step 7: Push Docker Image to ACR

```bash
docker push mydockeracr.azurecr.io/dockerized-app:1.0
```

### Step 8: Verify Image in ACR

```bash
az acr repository list --name mydockeracr --output table
```

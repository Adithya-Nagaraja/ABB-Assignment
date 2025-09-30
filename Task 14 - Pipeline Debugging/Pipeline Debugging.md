# Azure DevOps Pipeline Debugging: Environment Variable Issue

## Issue Overview

A DevOps pipeline is failing due to errors in environment variable configuration. This is a **common real-time issue** when environment variables are incorrectly defined or accessed in the pipeline.

### Sample Real-Time Error

```
##[error]Environment variable 'MY_SECRET_KEY' is not set.
##[error]Cannot access environment variable 'API_ENDPOINT'
```

This error usually occurs when:

* The variable is not defined in the pipeline.
* The variable is defined but not accessible in the correct scope.
* Incorrect syntax is used in the YAML file.

---

## Step-by-Step Troubleshooting

### Step 1: Check Pipeline Variables in Azure DevOps UI

1. Navigate to your Azure DevOps project → Pipelines → Edit pipeline.
2. Go to **Variables** tab.
3. Ensure all required environment variables are listed:

   * Example:

     * `MY_SECRET_KEY`
     * `API_ENDPOINT`
4. Make sure secrets are marked as **secret** and scope is correct.

---

### Step 2: Verify YAML Syntax for Environment Variables

Example snippet of correct YAML usage:

```yaml
trigger:
- main

pool:
  vmImage: 'ubuntu-latest'

variables:
  MY_SECRET_KEY: $(MY_SECRET_KEY)
  API_ENDPOINT: 'https://api.abb.com'

stages:
- stage: Build
  jobs:
  - job: BuildJob
    steps:
    - script: echo "Using API endpoint: $(API_ENDPOINT)"
      displayName: 'Print API Endpoint'
    - script: echo "Secret key length: ${MY_SECRET_KEY}"
      displayName: 'Print Secret Key Length'
```

**Common mistakes:**

* Missing `$()` for variable substitution.
* Using wrong syntax in bash scripts (`$VAR` vs `$(VAR)` in YAML).
* Secret variables cannot be echoed directly; use cautiously.

---

### Step 3: Check Scope of Variables

* Pipeline variables can be **pipeline-level**, **stage-level**, or **job-level**.
* If a variable is defined at pipeline level, it must be accessed correctly at job level.
* Example: Job-specific variable override:

```yaml
jobs:
- job: TestJob
  variables:
    API_ENDPOINT: 'https://staging-api.abb.com'
```

---

### Step 4: Test the Pipeline Locally (Optional)

* Use Azure DevOps CLI or Docker container to simulate the environment.
* Ensure environment variables are picked up correctly.

---

### Step 5: Run Pipeline and Review Logs

1. Queue the pipeline.
2. Check **logs for each step**.
3. Confirm variables are accessible and correctly substituted.
4. Example of successful execution:

```
Using API endpoint: https://api.example.com
Secret key length: 32
```

---

### Step 6: Fix and Commit YAML

* Update the `.yml` file with correct variable references.
* Commit and push to trigger pipeline.
* Ensure the pipeline passes successfully.

---

**End of Document**

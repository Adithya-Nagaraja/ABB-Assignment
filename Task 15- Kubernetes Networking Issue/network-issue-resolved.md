# AKS Networking Issue Investigation and Resolution

## Issue Summary

Pods in the AKS cluster were unable to communicate with external services, causing failures in outbound network requests. This affected application functionality and external API integrations.

**Symptoms observed:**

* Pods failing to reach external services.
* Timeouts when performing `curl` or API requests from pods.
* Network-related errors in pod logs.

---

## Step 1: Verify Pod Status

Check all pods in the namespace for readiness:

```bash
kubectl get pods -n <namespace>
```

**Example output:**

it shows the identity, health, uptime, and stability of each pod.

All pods are running, indicating that the issue is likely network-related, not pod scheduling.

---

## Step 2: Describe a Pod for Network Information

```bash
kubectl describe pod frontend-5d9f6d4b5c-abcde -n <namespace>
```

**Sample logs from `kubectl describe pod`:**


If we get the error: **Readiness probe failed: Get "http://10.244.1.5:8080/healthz": dial tcp 10.244.1.5:8080: i/o timeout**

The pod is not ready because its readiness probe is failing repeatedly, likely due to network issues, the application not responding, or the endpoint being incorrect.

* Indicates pods are running but failing network checks.


## Step 3: Inspect Pod Logs

```bash
kubectl logs frontend-5d9f6d4b5c-abcde -n <namespace>
```

**Sample pod logs:**


 ERROR Connection to external API timed out
 ERROR Failed to fetch resource: dial tcp 52.123.45.67:443: i/o timeout


* Confirms outbound traffic to external endpoints is blocked.

---

## Step 4: Test Network Connectivity from Pod

```bash
kubectl exec -it frontend-5d9f6d4b5c-abcde -n <namespace> -- ping 8.8.8.8
kubectl exec -it frontend-5d9f6d4b5c-abcde -n <namespace> -- curl -v https://www.abb.com
```

**Example output:**

If we get
ping: connect: Network is unreachable
curl: (7) Failed to connect to www.google.com port 443: Network is unreachable


* Confirms pods cannot reach external network.

---

## Step 5: Check Azure Network Configuration

1. **Verify AKS cluster node subnet configuration**.

   ```bash
   az network vnet subnet list --resource-group <RG> --vnet-name <VNetName>
   ```
2. **Check NSGs (Network Security Groups)**:

   * Ensure outbound traffic is allowed for node subnets.
   * Rules should allow at least ports 80 and 443.
3. **Check Azure Firewall or any custom routes** blocking outbound connections.

---

## Step 6: Verify Azure CNI and IP Allocation

* List node IP addresses:

```bash
kubectl get nodes -o wide
```

* Check if pods have IP addresses assigned:

```bash
kubectl get pods -o wide -n <namespace>
```

* Ensure IPs are in the correct VNet and subnet.

---

## Step 7: Test Outbound Connectivity from Node

```bash
az aks nodepool list --resource-group <RG> --cluster-name <AKSCluster>
```

* SSH into a node and try to `curl` external services.
* If node can access, issue is CNI/pod network related.
* If node cannot, issue is Azure NSG, route table, or firewall related.

---

## Step 8: Resolution Steps

1. **Fix NSG Rules**:

   * Ensure outbound rules allow 0.0.0.0/0 for required ports.

2. **Check UDRs (User Defined Routes)**:

   * Ensure there is no misconfigured route that blocks outbound traffic.

3. **Restart Pods**:

```bash
kubectl delete pod -n <namespace> --all
```

4. **Verify Connectivity**:

```bash
kubectl exec -it <pod> -n <namespace> -- curl -v https://www.abb.com
```

**Successful output:**

```
* Connected to www.google.com (142.250.190.100) port 443 (#0)
* TLS handshake completed
* HTTP/2 200
```

---

## Step 9: Post-resolution Verification

* Check application logs:

```bash
kubectl logs frontend-5d9f6d4b5c-abcde -n <namespace>
```

* Confirm no network errors.

* Confirm service connectivity:

```bash
kubectl exec -it frontend-5d9f6d4b5c-abcde -n <namespace> -- curl -v https://api.external-service.com
```

---


## Conclusion

The issue was caused by **misconfigured NSG or route blocking outbound traffic from the AKS nodes**, preventing pods from reaching external services. Updating network security rules and validating pod IP allocation resolved the issue.

---

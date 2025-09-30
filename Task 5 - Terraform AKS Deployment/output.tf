output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_resource_group" {
  description = "The resource group of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.resource_group_name
}

output "aks_cluster_location" {
  description = "The location of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.location
}

output "kube_config" {
  description = "Kubeconfig for the AKS cluster (sensitive)"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive   = true
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace used by Azure Monitor"
  value       = azurerm_log_analytics_workspace.aks_law.id
}

output "node_resource_group" {
  description = "The node resource group managed by AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}

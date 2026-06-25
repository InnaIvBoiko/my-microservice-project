output "jenkins_release_name" {
  description = "Name of the Jenkins Helm release"
  value       = helm_release.jenkins.name
}

output "jenkins_namespace" {
  description = "Kubernetes namespace where Jenkins is deployed"
  value       = helm_release.jenkins.namespace
}

output "jenkins_url" {
  description = "Public Jenkins URL (available once the LoadBalancer is provisioned)"
  value = try(
    "http://${data.kubernetes_service_v1.jenkins.status[0].load_balancer[0].ingress[0].hostname}",
    "LoadBalancer hostname not yet available — retry after provisioning"
  )
}

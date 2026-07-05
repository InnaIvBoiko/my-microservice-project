resource "kubernetes_ingress_v1" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = var.jenkins_namespace
    annotations = {
      "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"      = "ip"
      "alb.ingress.kubernetes.io/certificate-arn"  = aws_acm_certificate_validation.ingress.certificate_arn
      "alb.ingress.kubernetes.io/listen-ports"     = jsonencode([{ HTTPS = 443 }, { HTTP = 80 }])
      "alb.ingress.kubernetes.io/ssl-redirect"     = "443"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/login"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      host = "${var.jenkins_subdomain}.${var.domain_name}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "jenkins"
              port { number = 80 }
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.alb_controller,
    aws_acm_certificate_validation.ingress,
  ]
}

resource "kubernetes_ingress_v1" "argocd" {
  metadata {
    name      = "argocd"
    namespace = var.argocd_namespace
    annotations = {
      "alb.ingress.kubernetes.io/scheme"            = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"       = "ip"
      "alb.ingress.kubernetes.io/certificate-arn"   = aws_acm_certificate_validation.ingress.certificate_arn
      "alb.ingress.kubernetes.io/listen-ports"      = jsonencode([{ HTTPS = 443 }, { HTTP = 80 }])
      "alb.ingress.kubernetes.io/ssl-redirect"      = "443"
      # ArgoCD runs in insecure mode (no internal TLS); ALB terminates TLS externally
      "alb.ingress.kubernetes.io/backend-protocol"  = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-path"  = "/healthz"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      host = "${var.argocd_subdomain}.${var.domain_name}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              # ArgoCD server service name = Helm release name + "-server"
              name = "argo-cd-server"
              port { number = 80 }
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.alb_controller,
    aws_acm_certificate_validation.ingress,
  ]
}

# Route53 ALIAS records pointing subdomains at the ALBs.
# These require a second 'terraform apply' because the ALB hostname
# is only known after the Ingress controller provisions the load balancer.
data "kubernetes_ingress_v1" "jenkins_alb" {
  metadata {
    name      = kubernetes_ingress_v1.jenkins.metadata[0].name
    namespace = kubernetes_ingress_v1.jenkins.metadata[0].namespace
  }
  depends_on = [kubernetes_ingress_v1.jenkins]
}

data "kubernetes_ingress_v1" "argocd_alb" {
  metadata {
    name      = kubernetes_ingress_v1.argocd.metadata[0].name
    namespace = kubernetes_ingress_v1.argocd.metadata[0].namespace
  }
  depends_on = [kubernetes_ingress_v1.argocd]
}

# ALB hosted zone IDs per region (fixed by AWS)
locals {
  alb_zone_ids = {
    us-east-1      = "Z35SXDOTRQ7X7K"
    us-east-2      = "Z3AADJGX6KTTL2"
    us-west-1      = "Z368ELLRRE2KJ0"
    us-west-2      = "Z1H1FL5HABSF5"
    eu-west-1      = "Z32O12XQLNTSW2"
    eu-central-1   = "Z215JYRZR1TBD5"
    ap-southeast-1 = "Z1LMS91P8CMLE5"
    ap-northeast-1 = "Z14GRHDCWA56QT"
  }
  alb_zone_id = local.alb_zone_ids[var.region]
}

resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.jenkins_subdomain}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = try(data.kubernetes_ingress_v1.jenkins_alb.status[0].load_balancer[0].ingress[0].hostname, "pending")
    zone_id                = local.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "argocd" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.argocd_subdomain}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = try(data.kubernetes_ingress_v1.argocd_alb.status[0].load_balancer[0].ingress[0].hostname, "pending")
    zone_id                = local.alb_zone_id
    evaluate_target_health = true
  }
}

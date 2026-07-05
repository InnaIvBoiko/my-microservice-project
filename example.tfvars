# Copy this file to terraform.tfvars and fill in your values.
# terraform.tfvars is gitignored — never commit real secrets.

aws_region   = "us-west-2"
project_name = "final-project"

jenkins_admin_username = "admin"
jenkins_admin_password = "" # min 12 chars

github_username = "" # e.g. InnaIvBoiko
github_token    = "" # GitHub PAT with repo + workflow scopes

grafana_admin_password = "" # min 12 chars

db_password = "" # RDS master password

django_secret_key = "" # Django SECRET_KEY for the django-app deployment

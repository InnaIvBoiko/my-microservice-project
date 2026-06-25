pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: jenkins-kaniko
spec:
  serviceAccountName: jenkins-sa
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.23.2-debug
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d
    - name: git
      image: alpine/git:2.43.0
      command:
        - sleep
      args:
        - 99d
"""
    }
  }

  environment {
    // Replace ACCOUNT_ID with your AWS account number.
    // The repo name matches the ECR module: project_name + "-ecr".
    ECR_REGISTRY = "740948698725.dkr.ecr.us-west-2.amazonaws.com"
    IMAGE_NAME   = "lesson-8-9-ecr"
    IMAGE_TAG    = "v1.0.${BUILD_NUMBER}"

    GIT_REPO_URL = "https://github.com/InnaIvBoiko/my-microservice-project.git"
    GIT_BRANCH   = "lesson-8-9"

    COMMIT_NAME  = "jenkins"
    COMMIT_EMAIL = "jenkins@localhost"
  }

  stages {
    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          sh """
            /kaniko/executor \\
              --context      \${WORKSPACE}/docker/django \\
              --dockerfile   \${WORKSPACE}/docker/django/Dockerfile \\
              --destination  \${ECR_REGISTRY}/\${IMAGE_NAME}:\${IMAGE_TAG} \\
              --destination  \${ECR_REGISTRY}/\${IMAGE_NAME}:latest \\
              --cache=true \\
              --cache-repo   \${ECR_REGISTRY}/\${IMAGE_NAME}-cache
          """
        }
      }
    }

    stage('Update Helm Chart Tag') {
      steps {
        container('git') {
          withCredentials([usernamePassword(
            credentialsId: 'github-token',
            usernameVariable: 'GIT_USERNAME',
            passwordVariable: 'GIT_PAT'
          )]) {
            sh """
              git clone https://\${GIT_USERNAME}:\${GIT_PAT}@github.com/InnaIvBoiko/my-microservice-project.git repo
              cd repo
              git checkout \${GIT_BRANCH}

              sed -i "s|^  tag:.*|  tag: \${IMAGE_TAG}|" charts/django-app/values.yaml

              git config user.email "\${COMMIT_EMAIL}"
              git config user.name  "\${COMMIT_NAME}"

              git add charts/django-app/values.yaml
              git commit -m "ci: update image tag to \${IMAGE_TAG} [skip ci]"
              git push origin \${GIT_BRANCH}
            """
          }
        }
      }
    }
  }

  post {
    success {
      echo "Image ${ECR_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} pushed. ArgoCD will sync automatically."
    }
    failure {
      echo "Pipeline failed. Check logs above."
    }
  }
}

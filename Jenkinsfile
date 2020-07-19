@Library('github.com/releaseworks/jenkinslib') _
pipeline {
    environment {
    registry = "utsavpreet27/fast_api_k8s"
    registryCredential = 'dockerhub'
    dockerImage = ''
    }
    agent { docker { image 'python:3.7-slim' } }
    stages {
        stage('lint') {
            steps {
                sh 'pip install -r requirements.txt --quiet'
                sh 'black main.py'
                sh 'flake8 main.py'
            }
        }
        stage('lint_docker') {
        agent { docker { image 'hadolint/hadolint' } }
            steps {
                sh 'hadolint Dockerfile'
            }
        }
        stage('build') {
            steps {
                script {
                  dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('push_image') {
          steps {
            script {
              docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
                dockerImage.push('latest')
              }
            }
        }
        }
        stage('remove_image') {
            steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    stage('deploy') {
      agent { docker { image 'bearengineer/awscli-kubectl'}}
            steps{
            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        AWS("--region=us-east-1 eks --region us-east-1 update-kubeconfig --name capstone-udacity")
    }
        sh "kubectl set image deployment/my-app-1  my-app-1=utsavpreet27/fast_api_k8s:$BUILD_NUMBER"
      }
    }
    }
}
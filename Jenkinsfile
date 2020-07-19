pipeline {
    environment {
    registry = "utsavpreet27/fast_api_k8s"
    registryCredential = 'dockerhub'
    dockerImage = ''
    AWS_CRED = credentials('aws-key')
    MY_KUBECONFIG = credentials('my-kubeconfig')
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
            sh "aws configure set aws_access_key_id $AWS_CRED_USR"
            sh "aws configure set aws_secret_access_key $AWS_CRED_PSW"
            sh "aws configure set default.region us-east-1"
        sh("kubectl --kubeconfig $MY_KUBECONFIG set image pod/my-app-1  my-app-1=utsavpreet27/fast_api_k8s:$BUILD_NUMBER")
        sh("kubectl --kubeconfig $MY_KUBECONFIG describe pod my-app-1")
      }
    }
    }
}
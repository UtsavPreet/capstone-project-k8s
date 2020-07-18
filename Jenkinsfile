pipeline {
    agent { docker { image 'python:3.7-slim' } }
    stages {
        stage('lint') {
            steps {
                sh 'pip install requirements.txt --quiet'
                sh 'black main.py'
                sh 'flake8 main.py'
            }
        }
        stage('test') {
            steps {
                sh 'python --version'
            }
        }
        stage('build') {
        agent { docker { image 'docker:latest' } }
            steps {
                sh 'docker login -u utsavpreet27 -p something'
                sh 'docker build -t fast_api_k8s'
                sh 'docker tag fast_api_k8s utsavpreet27/fast_api_k8s'
                sh 'docker push utsavpreet27/fast_api_k8s'
            }
        }
    }
}
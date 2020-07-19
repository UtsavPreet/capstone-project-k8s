# Udacity Cloud DevOps Engineer NanoDegree Capstone Project 

## Purpose 

This project deploys a FASTAPI based project on AWS EKS Cluster. The project is deployed using Jenkins, where the pipeline consists of:

1. lint of project code and dockerfile 
2. build of docker image 
3. pushing of docker image to registry 
4. updating the deployment on K8s with the new version (Rolling Deployment)

Project is Live at: http://capstone-project.utsav.io/ 
http://capstone-project.utsav.io/docs for API docs


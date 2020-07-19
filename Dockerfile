FROM python:3.7-slim
ENV PROJECT_ROOT /capstone-project-k8s
WORKDIR $PROJECT_ROOT
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt --quiet
COPY . .
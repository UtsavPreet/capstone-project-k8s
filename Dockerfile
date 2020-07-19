FROM python:3.7-slim
ENV PROJECT_ROOT /capstone-project-k8s
RUN apt-get update && apt-get install -y locales && sed -i "/^#.* en_US.UTF-8 /s/^#//" /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
WORKDIR $PROJECT_ROOT
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt --quiet
COPY . .
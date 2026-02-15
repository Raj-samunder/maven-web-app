pipeline {
    agent any

    tools {
        maven 'Maven-3.9.12'   // Make sure this matches your Jenkins tool name
    }

    environment {
        IMAGE_NAME = 'rajsamunder/mavenwebapp'
        IMAGE_TAG  = 'latest'
    }

    stages {

        stage('Clone GitHub Repo') {
            steps {
                git(
                    url: 'https://github.com/Raj-samunder/maven-web-app.git',
                    credentialsId: 'github_creds'
                )
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build & Push') {
            steps {
                // Login to Docker Hub using credentials
                withCredentials([usernamePassword(
                    credentialsId: 'docker_creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }

                // Build Docker image
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."

                // Push Docker image to Docker Hub
                sh "docker push $IMAGE_NAME:$IMAGE_TAG"
            }
        }

        stage('K8s Deploy') {
            steps {
                // Make sure kubeconfig is configured for ubuntu user
                sh 'kubectl apply -f k8s-deploy.yml'
            }
        }

    }

    post {
        always {
            cleanWs()  // Clean workspace after pipeline
        }
    }
}

pipeline {
    agent any

    environment {
        // 1. CHANGE THIS to your actual Docker Hub username
        DOCKER_USER = "your-docker-hub-username"
        
        // 2. This must match the ID you gave your credentials in Jenkins
        REGISTRY_CREDENTIALS = 'docker-hub-creds'
        
        IMAGE_NAME = "my_meg_app"
        CONTAINER_NAME = "my_meg_container"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Pulling code from GitHub...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo '🔨 Building Docker Image...'
                // Tags the image correctly for Docker Hub (username/repository:tag)
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running Python Syntax Check...'
                // Ensures your Flask app.py has no indentation or syntax errors
                sh "python3 -m py_compile app.py"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // This block handles 'docker login' and 'docker logout' automatically
                    docker.withRegistry('', "${REGISTRY_CREDENTIALS}") {
                        echo '📤 Pushing Image to Docker Hub...'
                        sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy Local') {
            steps {
                echo '🚀 Refreshing Local Container...'
                // Stops and removes the old container if it exists, then runs the new one
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                sh "docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline Finished Successfully! Your app is live at http://localhost:5000'
        }
        failure {
            echo '❌ Pipeline Failed. Please check the Console Output for errors.'
        }
    }
}

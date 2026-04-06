pipeline {
    agent any

    environment {
        DOCKER_USER = "meghanagowda282005"
        REGISTRY_CREDENTIALS = 'python_app_password'
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

        stage('Build Docker Image') {
            steps {
                echo '🔨 Building Docker Image...'
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running Python Syntax Check...'
                sh "python3 -m py_compile app.py"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${REGISTRY_CREDENTIALS}") {
                        echo '📤 Pushing Image to Docker Hub...'
                        sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy Local Container') {
            steps {
                echo '🚀 Refreshing Local Container...'
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                sh "docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }
    }

    post {
        success {
            echo '✅ Success! Image pushed & container running locally.'
        }
        failure {
            echo '❌ Pipeline Failed. Check logs (Docker login / build / push errors).'
        }
    }
}

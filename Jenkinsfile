pipeline {
    agent any

    environment {
        IMAGE_NAME = "my_meg_app"
        CONTAINER_NAME = "my_meg_container"
    }

    stages {
        stage('Build') {
            steps {
                echo '🔨 Building Docker Image...'
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running Python Syntax Check...'
                // This checks your app.py for errors without running the full container
                sh "python3 -m py_compile app.py"
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying Container...'
                // Stop and remove existing container if it exists to avoid naming conflicts
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                
                // Run the new container
                sh "docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline finished successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check the logs above.'
        }
    }
}

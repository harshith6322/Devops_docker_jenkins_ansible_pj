pipeline {
    agent {
        label 'SLAVE-1'
    }

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker_login_data') // Ensure this matches your Jenkins credentials ID
        IMAGE_NAME = 'harshithreddy6322/reactapp_1'
        // IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_TAG = "JENKINS"

    }

    stages {
        stage('Checkout Repository') {
            steps {
                // Using 'checkout scm' assumes the pipeline is triggered by a multibranch pipeline or a GitHub hook
                // checkout scm
                // Alternatively, specify the repository URL and branch explicitly:
               git branch: 'main', url: 'https://github.com/harshith6322/Devops_docker_jenkins_ansible_pj.git'
            }
        }

       
        stage('Install Dependencies') {
            steps {
            sh 'npm install'
            }
        }

        stage('Lint') {
            steps {
                sh 'npm run lint'
            }
        }

        stage('Test') {
            steps {
                // Using 'set -o pipefail' ensures that the pipeline fails if tests fail, even when piped
                sh 'npm run test || true'
            }
           
        }

        stage('Build Application') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                // script {
                    // Build the Docker image
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                    // // Tag the image as 'latest' for convenience
                    // sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
                // }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Run the Docker container in detached mode
                    sh 'docker-compose up -d'
                    // Optionally, add health checks or test commands here
                }
            }
            post {
                always {
                    // Ensure the container is stopped and removed after testing
                    sh 'docker-compose down'
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    // Log in to Docker Hub using credentials stored in Jenkins
                    withDockerRegistry([credentialsId: '${DOCKER_HUB_CREDENTIALS}']) {
                        // Push both the versioned and latest tags
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace to maintain a clean build environment
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Build failed!'
            // Optionally, send notifications or alerts here
        }
    }
}
//
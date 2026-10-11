pipeline {
    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    environment {
        APP_NAME   = "oneapp"
        PORT       = "5050"
        KUBECONFIG = "/var/jenkins_home/.kube/config"
        IMAGE_REPO = "shaharc20"
        IMAGE_TAG  = "${BUILD_NUMBER}"
        DOCKER_HOST       = "tcp://192.168.49.2:2376"
        DOCKER_TLS_VERIFY = "1"
        DOCKER_CERT_PATH  = "/var/jenkins_home/.minikube-certs"
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Setup Python Environment') {
            steps {
                sh '''
                    pip3 install --break-system-packages --user --upgrade pip
                    pip3 install --break-system-packages --user -r requirements.txt
                '''
            }
        }

        stage('Run Flask Application') {
            steps {
                sh '''
                    nohup python3 app.py > flask.log 2>&1 &
                    sleep 5
                '''
            }
        }

        stage('Verify Application') {
            steps {
                sh '''
                    curl -s http://localhost:${PORT}/health | grep '"ok"'
                    echo "oneapp is running successfully."
                '''
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'flask.log', allowEmptyArchive: true
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t ${IMAGE_REPO}:${IMAGE_TAG} .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'helm upgrade oneapp chart/ --install --set image.tag=${IMAGE_TAG}'
                sh 'kubectl rollout status deploy/oneapp-oneapp --timeout=120s'
            }
        }
    }

    post {
        always {
            sh 'pkill -f "python3 app.py" || true'
        }
        success { echo "Build ${BUILD_NUMBER} deployed to Kubernetes!" }
        failure { echo "Build failed - check flask.log in artifacts." }
    }
}

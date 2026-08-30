pipeline {
    agent any

    environment {
        APP_NAME = "oneapp"
        PORT     = "5050"
        KUBECONFIG = "/tmp/kubeconfig"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python Environment') {
            steps {
                sh '''
                    pip3 install --user --upgrade pip
                    pip3 install --user -r requirements.txt
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

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    helm upgrade oneapp chart/ --install
                    kubectl rollout status deployment/oneapp-oneapp --timeout=60s
                '''
            }
        }
    }

    post {
        always {
            sh 'pkill -f "python3 app.py" || true'
            echo "Cleaning up workspace..."
        }
        success {
            echo "Build succeeded and deployed to Kubernetes!"
        }
        failure {
            echo "Build failed - check flask.log in artifacts."
        }
    }
}

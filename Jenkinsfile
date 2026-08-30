pipeline {
    agent any

    environment {
        APP_NAME = "oneapp"
        PORT     = "5050"
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
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Flask Application') {
            steps {
                sh '''
                    . venv/bin/activate
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
    }

    post {
        always {
            sh 'pkill -f "python3 app.py" || true'
            echo "Cleaning up workspace..."
        }
        success {
            echo "Build succeeded!"
        }
        failure {
            echo "Build failed - check flask.log in artifacts."
        }
    }
}

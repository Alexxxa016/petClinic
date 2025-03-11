pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Alexxxa016/petClinic.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('YourSonarQubeServerName') {
                    bat 'mvn sonar:sonar -Dsonar.projectKey=petclinic -Dsonar.host.url=https://sonarcloud.io'
                }
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}

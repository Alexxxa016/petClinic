pipeline {
    agent any

    tools {
        maven 'Maven3' 
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Alexxxa016/petClinic.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    def mvnHome = tool 'Maven3'
                    bat "\"${mvnHome}\\bin\\mvn\" clean install"
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    def mvnHome = tool 'Maven3'
                    bat "\"${mvnHome}\\bin\\mvn\" test"
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('YourSonarQubeServerName') {
                    script {
                        def mvnHome = tool 'Maven3'
                        bat "\"${mvnHome}\\bin\\mvn\" sonar:sonar -Dsonar.projectKey=petclinic -Dsonar.host.url=https://sonarcloud.io"
                    }
                }
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        success {
            echo ' Build succeeded!'
        }
        failure {
            echo ' Build failed.'
        }
    }
}

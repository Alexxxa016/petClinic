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
                script {
                    def mvnHome = tool 'Maven3'
                    bat "\"${mvnHome}\\bin\\mvn\" -Djava.net.preferIPv4Stack=true sonar:sonar -Dsonar.projectKey=petClinic -Dsonar.organization=alexxxa016 -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=e2f03d600aecd3d96d306941d3421dbc1b0a8388"
                }
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        success {
            discordSend webhookURL: 'https://discordapp.com/api/webhooks/1349452587828641853/dDVLmlCxc2fIwt6COEkWMeLSWv3RPbN189NP8Jy54Mgks_7XbfQFT63XhV5qB5JeyT6v',
                        channel: 'jenkins-notifications',
                        message: " Build succeeded: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                        color: 'green'
            echo 'Build succeeded!'
        }
        failure {
            discordSend webhookURL: 'https://discordapp.com/api/webhooks/1349452587828641853/dDVLmlCxc2fIwt6COEkWMeLSWv3RPbN189NP8Jy54Mgks_7XbfQFT63XhV5qB5JeyT6v',
                        channel: 'jenkins-notifications',
                        message: " Build failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                        color: 'red'
            echo 'Build failed!'
        }
    }
}

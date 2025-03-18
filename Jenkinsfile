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
                    // Using IPv4 flag to avoid connectivity issues
                    bat "\"${mvnHome}\\bin\\mvn\" -Djava.net.preferIPv4Stack=true sonar:sonar -Dsonar.projectKey=petClinic -Dsonar.organization=alexxxa016 -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=e2f03d600aecd3d96d306941d3421dbc1b0a8388"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Build the Docker image locally tagged as "petclinic"
                    bat "docker build -t petclinic ."
                    
                    // Deploy to AWS EC2:
                    // This SSH command connects to your EC2 instance and:
                    // 1. Removes any existing container named petclinic_container (ignoring errors if not present)
                    // 2. Runs the new container mapping port 8080.
                    bat 'ssh -i "C:\\Users\\T00222705\\Downloads\\petclinic-key.pem" ec2-user@3.89.139.25 "docker rm -f petclinic_container || true && docker run -d -p 8080:8080 --rm --name petclinic_container petclinic"'
                }
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        success {
            echo 'Build succeeded!!'
            script {
                def message = "Build succeeded: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
                bat """
                curl -H "Content-Type: application/json" -d "{\\"content\\": \\"${message}\\"}" https://discordapp.com/api/webhooks/1349452587828641853/dDVLmlCxc2fIwt6COEkWMeLSWv3RPbN189NP8Jy54Mgks_7XbfQFT63XhV5qB5JeyT6v
                """
            }
        }
        failure {
            echo 'Build failed!.'
            script {
                def message = "Build failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
                bat """
                curl -H "Content-Type: application/json" -d "{\\"content\\": \\"${message}\\"}" https://discordapp.com/api/webhooks/1349452587828641853/dDVLmlCxc2fIwt6COEkWMeLSWv3RPbN189NP8Jy54Mgks_7XbfQFT63XhV5qB5JeyT6v
                """
            }
        }
    }
}

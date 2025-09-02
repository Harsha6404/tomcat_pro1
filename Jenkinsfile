pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Harsha6404/java-project-maven-new.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mytomcat .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
               docker rm -f tomcat-app || true
               docker run -d --name tomcat-app -p 2222:8080 mytomcat

                '''
            }
        }
    }
}

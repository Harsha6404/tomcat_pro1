pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/Harsha6404/tomcat_pro1.git',
                    branch: 'main',
                    credentialsId: 'github-token'
                )
            }
        }
        stage('artifact') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'myapp', classifier: '', file: '**/*.war', type: 'war']], credentialsId: 'nexuscreds', groupId: 'in.reyaz', nexusUrl: '13.60.45.200:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'tomcat', version: '8.3.3-SNAPSHOT'
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
               docker run -d --name tomcat-app -p 1515:8080 mytomcat

                '''
            }
        }
    }
}

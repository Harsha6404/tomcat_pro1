pipeline {
    agent any
     steps {
        git(
            url: 'https://github.com/Harsha6404/tomcat_pro1.git',
            branch: 'main',
            credentialsId: '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'
        )
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

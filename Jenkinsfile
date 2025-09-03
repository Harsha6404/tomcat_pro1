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

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }
//                stage('artifact') {
//             steps {
//                 nexusArtifactUploader(
//     artifacts: [
//         [
//             artifactId: 'myapp',
//             classifier: '',
//             file: 'target/myapp.war',
//             type: 'war'
//         ]
//     ],
//     credentialsId: 'nexuscreds',
//     groupId: 'in.reyaz',
//     nexusUrl: '13.60.45.200:8081',
//     nexusVersion: 'nexus3',
//     protocol: 'http',
//     repository: 'tomcat',
//     version: '8.3.3-SNAPSHOT'
// )

//             }
//         }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mytomcat .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag mytomcat $DOCKER_USER/mytomcat:latest
                        docker push $DOCKER_USER/mytomcat:latest
                        docker logout
                    '''
                }
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
        stage('Docker Swarm Deploy') {
            steps {
                sh '''
                    docker service update --image mytomcat mytomcatservice || \
                    docker service create --name mytomcatservice -p 5151:8080 --replicas=7 mytomcat
                '''
            }
        }
    }
}

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t longehdocker/task1jenk .
                docker build -t longehdocker/task1-nginx nginx
                '''
            }

        }
        stage('Push') {
            steps {
                sh '''
                docker push longehdocker/task1jenk
                docker push longehdocker/task1-nginx
                '''
            }

        }
        stage('Deploy') {
            steps {
                sh '''
                ssh jenkins@long-jenkins-deploy <<EOF
                docker pull longehdocker/task1jenk
                docker pull longehdocker/task1jenk
                
                docker stop nginx && echo "Stopped nginx" || echo "nginx is not running"
                docker rm nginx && echo "removed nginx" || echo "nginx does not exist"
                for 1 in {1..3}; do
                docker stop flask-app-${i} && echo "Stopped flask-app" || echo "flask-app is not running"
                done
                for 1 in {1..3}; do
                docker rm flask-app-${i} && echo "removed flask-app" || echo "flask-app does not exist"
                done
                docker network rm task1-net && echo "removed network" || echo "network already removed"
                docker network create task1-net
                for 1 in {1..3}; do
                docker run -d --name flask-app-${i} --network task1-net longehdocker/task1jenk
                done
                docker run -d --name nginx --network task1-net -p 80:80 longehdocker/task1-nginx
                '''
            }

        }

    }

}
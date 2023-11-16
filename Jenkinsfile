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
                docker pull longehdocker/task1-nginx
                
                docker stop nginx && echo "Stopped nginx" || echo "nginx is not running"
                docker rm nginx && echo "removed nginx" || echo "nginx does not exist"
                docker stop flask-app-1 && echo "Stopped flask-app" || echo "flask-app is not running"
                docker rm flask-app-1 && echo "removed flask-app" || echo "flask-app does not exist"
                docker stop flask-app-2 && echo "Stopped flask-app" || echo "flask-app is not running"
                docker rm flask-app-2 && echo "removed flask-app" || echo "flask-app does not exist"
                docker stop flask-app-3 && echo "Stopped flask-app" || echo "flask-app is not running"
                docker rm flask-app-3 && echo "removed flask-app" || echo "flask-app does not exist"
                docker network rm task1-net && echo "removed network" || echo "network already removed"
                docker network create task1-net
                docker run -d --name flask-app-1 --network task1-net longehdocker/task1jenk
                docker run -d --name flask-app-2 --network task1-net longehdocker/task1jenk
                docker run -d --name flask-app-3 --network task1-net longehdocker/task1jenk
                docker run -d --name nginx --network task1-net -p 80:80 longehdocker/task1-nginx
                '''
            }

        }

    }

}
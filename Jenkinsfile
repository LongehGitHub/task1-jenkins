pipeline {
    agent any
    environment {
        YOUR_NAME = credentials("YOUR_NAME")
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t longehdocker/task1jenk:v${BUILD_NUMBER} .
                docker build -t longehdocker/task1-nginx
                '''
            }

        }
        stage('Push') {
            steps {
                sh '''
                docker push longehdocker/task1jenk:v${BUILD_NUMBER}
                docker build -t longehdocker/task1-nginx
                '''
            }

        }
        stage('Staging Deploy') {
            steps {
                sh '''
                kubectl apply -f nginx-config.yaml --namespace staging
                sed -e 's,{{YOUR_NAME}},'${YOUR_NAME}',g;' -e 's,{{version}},'${BUILD_NUMBER}',g;' app-manifest.yaml | kubectl apply -f - --namespace staging
                kubectl apply -f nginx-pod.yaml --namespace staging
                '''
            }

        }
        stage('Prod Deploy') {
            steps {
                sh '''
                kubectl apply -f nginx-config.yaml --namespace prod
                sed -e 's,{{YOUR_NAME}},'${YOUR_NAME}',g;' -e 's,{{version}},'${BUILD_NUMBER}',g;' app-manifest.yaml | kubectl apply -f - --namespace prod
                kubectl apply -f nginx-pod.yaml --namespace prod
                sleep 60
                kubectl get services --namespace prod
                '''
            }

        }

    }
}
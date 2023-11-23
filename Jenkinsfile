pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t longehdocker/task1jenk .
                '''
            }

        }
        stage('Push') {
            steps {
                sh '''
                docker push longehdocker/task1jenk
                '''
            }

        }
        stage('Deploy') {
            steps {
                sh '''
                kubectl apply -f .
                '''
            }

        }

    }

}
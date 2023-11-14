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
                // docker stop task1
                // docker rm task1
                docker run -d -p 80:5500 --name task1 longehdocker/task1jenk
                '''
            }

        }

    }

}
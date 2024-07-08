pipeline {
    agent {
        label 'Agent-1'
    }
    options {
        // Timeout counter starts BEFORE agent is allocated
        timeout(time: 1, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {
        stage('init') {
            steps {
                sh """
                 ls -ltr
                """
            }
        }
        stage('plan') {
            steps {
                sh 'echo this is test'
                sh 'sleep 10'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo this is deploy'
            }
        }

    }
    post { 
            always { 
            echo 'I will always say Hello again!'
        }
        sucess { 
            echo 'I will run pipe is sucess'
        }
        failure { 
            echo 'I will run pipe is failure'
        }
    
    }

}
pipeline {
    agent {
        label 'Agent-1'
    }
    options {
        // Timeout counter starts BEFORE agent is allocated
        timeout(time: 1, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }

    stages {
        stage('init') {
            steps {
                sh """
                 cd 01-vpc
                 terraform init
                """
            }
        }
        stage('plan') {
            steps {
               sh """
                cd 01-vpc
                terraform plan
               """
            }
        }
        stage('Deploy') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            steps {
                sh """
                cd 01-vpc
                terraform apply -auto-approve
                """
            }
        }

    }
    post { 
            always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        success { 
            echo 'I will run pipe is sucess'
        }
        failure { 
            echo 'I will run pipe is failure'
        }
    
    }

}
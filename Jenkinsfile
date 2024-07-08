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
    parameters {
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Pick something')

    }

    stages {
        stage('init') {
            steps {
                sh """
                 cd 01-vpc
                 terraform init -upgrade

                """
            }
        }
        stage('plan') {
            when {
                expression {
                    params.action == 'apply'
                }
            }
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
        stage('Destroy') {
            when {
                expression {
                    params.action == 'destroy'
                }

            }
            steps {
                sh """
                cd 01-vpc
                terraform destroy -auto-approve
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
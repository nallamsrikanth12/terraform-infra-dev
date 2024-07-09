pipeline {
    agent {
        label 'Agent-1'
    }
    options {
        // Timeout counter starts BEFORE agent is allocated
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    parameters {
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Pick something')
    }

    stages {
        stage('init') {
            steps {
                ansiColor('xterm') {
                    sh """
                    cd 01-vpc
                    terraform init -upgrade
                    """
                }
            }
        }
        stage('plan') {
            when {
                expression {
                    params.action == 'apply'
                }
            }
            steps {
                ansiColor('xterm') {
                    sh """
                    cd 01-vpc
                    terraform plan
                    """
                }
            }
        }
        stage('Deploy') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            steps {
                ansiColor('xterm') {
                    sh """
                    cd 01-vpc
                    terraform apply -auto-approve
                    """
                }
            }
        }
        stage('Destroy') {
            when {
                expression {
                    params.action == 'destroy'
                }
            }
            steps {
                ansiColor('xterm') {
                    sh """
                    cd 01-vpc
                    terraform destroy -auto-approve
                    """
                }
            }
        }
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        success { 
            echo 'I will run pipe is success'
        }
        failure { 
            echo 'I will run pipe is failure'
        }
    }
}

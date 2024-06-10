pipeline {
    agent any
    
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'test', 'prod'], description: 'Select environment')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/srinivas325/tf-state-s3.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    def tfvarsFile = "${params.ENVIRONMENT}.tfvars"
                    sh "terraform plan -var-file=${tfvarsFile} -out=tfplan"
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                script {
                    def autoApprove = params.ENVIRONMENT == 'prod' ? '-auto-approve' : ''
                    sh "terraform apply ${autoApprove} tfplan"
                }
            }
        }
    }
}

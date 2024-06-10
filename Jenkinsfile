pipeline {
    agent any
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'test', 'prod'], description: 'Select environment')
    }

    stages {
        stage('Checkout') {
            agent any
            steps {
                git branch: 'main', url: 'https://github.com/srinivas325/tf-state-s3.git'
            }
        }


        stage('Configure AWS Credentials') {
            agent any
            steps {
                withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                credentialsId: 'AWS-Creds']]) 
                {
                    script 
                    {
                        sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID'
                        sh 'aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY'
                        sh 'aws sts get-caller-identity'
                    }
                }
            }
        }
    stage('Cleanup') {
            steps {
                script {
                    sh """
                    rm -rf .terraform
                    rm -f terraform.tfstate.lock.info
                    """
                }
            }
        }
        stage('Terraform Init') {
            agent any
            steps {
                script {
                    sh 'terraform init -upgrade -no-color'
                              }
        }
    }

        stage('Terraform Plan') {
            agent any
            steps {

			script {
                    def tfvarsFile = "${params.ENVIRONMENT}.tfvars"
                    sh "terraform plan -no-color -input=false -var-file=${tfvarsFile} -out=tfplan"
                }
            }
    }
    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }
    stage('Terraform Apply') {
            agent any
            steps {
                script {
                    sh 'terraform apply -input=false myplan'
            }
        }
    }
    
}
   
}
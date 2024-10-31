pipeline {
  node {
    label 'java-agent'
  }
  stages {
    stage('VPC'){
      steps {
        sh """
        cd 01-VPC
        terraform init --reconfigure
        terraform apply -auto-approve

        """
      }
    }
    stage('VPC'){
      steps {
        sh """
        cd 01-VPC
        terraform init --reconfigure
        terraform apply -auto-approve

        """
      }
    }
    stage('VPC'){
      steps {
        sh """
        cd 01-VPC
        terraform init --reconfigure
        terraform apply -auto-approve

        """
      }
    }
    stage('VPC'){
      steps {
        sh """
        cd 01-VPC
        terraform init --reconfigure
        terraform apply -auto-approve

        """
      }
    }
  }
}

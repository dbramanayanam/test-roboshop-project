pipeline {
  agent {
    node {
        label 'java-agent'
    }
  }
  stages {
    stage('VPC'){
      steps {
        sh """
        cd 01-VPC
        terraform init -reconfigure
        terraform apply -auto-approve

        """
      }
    }
    stage('SG'){
      steps {
        sh """
        cd 02-SG
        terraform init -reconfigure
        terraform apply -auto-approve

        """
      }
    }
    stage('VPN'){
      steps {
        sh """
        cd 03-VPN
        terraform init -reconfigure
        terraform apply -auto-approve

        """
      }
    }
    stage('EC2'){
      steps {
        sh """
        cd 04-Ec2
        terraform init -reconfigure
        terraform apply -auto-approve

        """
      }
    }
  }
}

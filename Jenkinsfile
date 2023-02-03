node {
    stage('CLEAN WORKSPACE'){
        cleanWs()
    }
    stage('GIT CLONE') { 
        git branch: 'application_deployment', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/deployment.git'        
    }
    stage('UPDATE DOCKER COMPOSE'){
        sh """
            sed -i \'s|{{ version }}|${version}|g\' ./packer/ansible/test-app/files/docker-compose.yml
        """
    }
    stage('PACKER TEST'){
        dir('packer') {
            sh """
                packer init .
                packer fmt .
            """
        }
    }
    stage('PACKER CREATE APPLICATION AMI'){
        dir('packer') {
            sh """
                packer build source.pkr.hcl
            """
        }
    }
    stage('Terraform CODE TEST TEMPLATE'){
        dir("terraform/wrapper/asg"){
            sh """
                terraform init
                terraform fmt
                terraform validate
            """
        }
    }
    stage('Terraform CODE TEST TEMPLATE'){
        dir("terraform/wrapper/asg"){
            sh """
                terraform apply -auto-approve
            """
        }
    }
}
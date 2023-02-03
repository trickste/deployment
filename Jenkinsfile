node {
    stage('CLEAN WORKSPACE'){
        cleanWs()
    }
    stage('GIT CLONE') { 
        git branch: 'architecture', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/test-app-architecture.git'        
    }
    stage('TERRAFORM TEST'){
        dir('wrapper/vpc/'){
            sh """
                terraform init
                terraform fmt
                terraform validate
            """
        }
        dir('wrapper/ec2/'){
            sh """
                terraform init
                terraform fmt
                terraform validate
            """
        }
        dir('wrapper/alb/'){
            sh """
                terraform init
                terraform fmt
                terraform validate
            """
        }
    }
    stage('TERRAFORM SETUP ARCHITECTURE'){
        dir('wrapper/vpc/'){
            sh """
                terraform apply -auto-approve
            """
        }
        dir('wrapper/ec2/'){
            sh """
                terraform apply -auto-approve
            """
        }
        dir('wrapper/alb/'){
            sh """
                terraform apply -auto-approve
            """
        }
    }
}
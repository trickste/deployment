node {
    stage('CLEAN WORKSPACE'){
        cleanWs()
    }
    stage('GIT CLONE') { 
        git branch: 'application_deployment', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/deployment.git'        
    }
    stage('PACKAGE') {
        withMaven(jdk: 'jdk', maven: 'maven') {
            sh 'mvn clean package'
        }
    }
    stage('TESTING'){
        echo "run mvn tests and check through gates"
    }
    stage('COLLECT PACKAGE FILES') {
        echo "Creating delivery package folder"
    }
    stage('DOCKERIZE'){
        dir('delivery_package') {
            sh 'docker image build -t tricksterepo/delivery .'
        }
    }
    stage('PUSH CREATED IMAGE'){
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh '''
                echo ${password} | docker login -u "${username}" --password-stdin
                docker push tricksterepo/delivery    
            '''
        }
    }
}

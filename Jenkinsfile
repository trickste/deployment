node {
    stage('CLEAN WORKSPACE'){
        cleanWs()
    }
    stage('GIT CLONE') { 
        git branch: 'main', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/testrepo.git'
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
        sh 'mkdir -p delivery_package'
        sh 'cp wfReportingConfig.yaml delivery_package/'
        sh 'cp delivery/app* delivery_package/'
        sh 'cp delivery/src/main/resources/application.yml delivery_package/'
        sh 'cp delivery/target/delivery-0.9.0-SNAPSHOT.jar delivery_package/'
        git branch: 'delivery', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/deployment.git'        
        sh 'cp Dockerfile delivery_package/'
        sh 'ls delivery_package/'
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

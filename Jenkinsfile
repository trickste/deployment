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
        echo "Creating packaging package folder"
        sh 'mkdir -p packaging_package'
        sh 'cp wfReportingConfig.yaml packaging_package/'
        sh 'cp packaging/app* packaging_package/'
        sh 'cp packaging/target/packaging-0.9.0-SNAPSHOT.jar packaging_package/'
        git branch: 'packaging', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/deployment.git'        
        sh 'cp Dockerfile packaging_package/'
        sh 'ls packaging_package/'
    }
    stage('DOCKERIZE'){
        dir('packaging_package') {
            sh 'docker image build -t tricksterepo/packaging .'
        }
    }
    stage('PUSH CREATED IMAGE'){
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh '''
                echo ${password} | docker login -u "${username}" --password-stdin
                docker push tricksterepo/packaging    
            '''
        }
    }
}

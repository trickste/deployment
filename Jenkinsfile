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
        echo "Creating styling package folder"
        sh 'mkdir -p styling_package'
        sh 'cp wfReportingConfig.yaml styling_package/'
        sh 'cp styling/app* styling_package/'
        sh 'cp styling/target/styling-0.9.0-SNAPSHOT.jar styling_package/'
        git branch: 'styling', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/deployment.git'        
        sh 'cp Dockerfile styling_package/'
        sh 'ls styling_package/'
    }
    stage('DOCKERIZE'){
        dir('styling_package') {
            sh 'docker image build -t tricksterepo/styling .'
        }
    }
    stage('PUSH CREATED IMAGE'){
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh '''
                echo ${password} | docker login -u "${username}" --password-stdin
                docker push tricksterepo/styling    
            '''
        }
    }
}

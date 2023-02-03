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
        echo "Creating printing package folder"
        sh 'mkdir -p printing_package'
        sh 'cp wfReportingConfig.yaml printing_package/'
        sh 'cp printing/app* printing_package/'
        sh 'cp printing/target/printing-0.9.0-SNAPSHOT.jar printing_package/'
        git branch: 'printing', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/deployment.git'        
        sh 'cp Dockerfile printing_package/'
        sh 'ls printing_package/'
    }
    stage('DOCKERIZE'){
        dir('printing_package') {
            sh 'docker image build -t tricksterepo/printing .'
        }
    }
    stage('PUSH CREATED IMAGE'){
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh '''
                echo ${password} | docker login -u "${username}" --password-stdin
                docker push tricksterepo/printing    
            '''
        }
    }
}

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
        echo "Creating Shopping package folder"
        sh 'mkdir -p shopping_package'
        sh 'cp wfReportingConfig.yaml shopping_package/'
        sh 'cp shopping/app* shopping_package/'
        sh 'cp shopping/target/shopping-0.9.0-SNAPSHOT.jar shopping_package/'
        git branch: 'shopping', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/deployment.git'        
        sh 'cp Dockerfile shopping_package/'
        sh 'ls shopping_package/'
    }
    stage('DOCKERIZE'){
        dir('shopping_package') {
            sh 'docker image build -t tricksterepo/shopping .'
        }
    }
    stage('PUSH CREATED IMAGE'){
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh '''
                echo ${password} | docker login -u "${username}" --password-stdin
                docker push tricksterepo/shopping    
            '''
        }
    }
}

node {
    stage('GIT CLONE') { 
        git branch: 'main', credentialsId: 'GithubPassword', url: 'https://github.com/trickste/testrepo.git'
    }
    stage('PACKAGE') {
        withMaven(jdk: 'jdk', maven: 'maven') {
            sh 'mvn clean package'
        }
    }
    stage('TESTING'){

    }
    stage('COLLECT PACKAGE FILES') {
        echo "Creating Shopping package folder"
        sh 'mkdir shopping_package'
        sh 'cp Dockerfile shopping_package/'
        sh 'cp wfReportingConfig.yaml shopping_package/'
        sh 'cp shopping/app* shopping_package/'
        sh 'cp shopping/target/shopping-0.9.0-SNAPSHOT.jar shopping_package/'
        sh 'ls shopping_package/'
    }
    stage('DOCKERIZE'){
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh '''
                docker login -u "${username}" -p "${password}"
            '''
        }
        sh 'docker image build -t tricksterepo/shopping .'
    }
    stage('PUSH CREATED IMAGE'){
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh '''
                docker login -u "${username}" -p "${password}"
            '''
        }
        sh 'docker push tricksterepo/shopping'
    }
}

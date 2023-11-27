pipeline {
    agent {label 'jenkins'}
    triggers {
        pollSCM('* * * * *') 
    }
    stages {
        stage('vcs') {
            steps {
                git url: 'https://github.com/AJA1811/Project1.git', branch: 'main'
            }
        }
        stage('deploy') {
            steps {
                sh 'sudo cp -rf oxer-html /var/www/html'
            }
        }    
    }
}

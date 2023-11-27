pipeline{
    pollSCM{* * * * *}
        stages{
        stage('vcs'){
            steps{
              git url: 'https://github.com/AJA1811/Project1.git',
                  branch: 'main'
            }
        }
        stage('deploy'){
            steps{
                sh 'sudo chmod +x ./Project1/project.sh'
                sh 'sh ./Project1/project.sh'
            }
        }
    }
}
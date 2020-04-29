node {
    checkout scm
    properties(
        [
            pipelineTriggers([pollSCM('*/5 * * * *')])
        ]        
    )
    def easyetlImage = docker.build("gleisonbs/easyetl")
    stage('Preparation') {
        sh "git rev-parse --short HEAD > .git/commit-id"
        commit_id = readFile('.git/commit-id').trim()
    }
    stage('Unit Tests') {
        docker.inside {
            sh 'python -m pytest tests/unit/'
        }
    }
    stage('Docker build/push') {
        docker.withRegistry('http://index.docker.io/v1', 'dockerhub') {
            easyetlImage.push(commit_id)
            easyetlImage.push('latest')
        }
    }

}
node {
    checkout scm
    properties(
        [
            pipelineTriggers([pollSCM('*/5 * * * *')])
        ]        
    )
    stage('Preparation') {
        sh "git rev-parse --short HEAD > .git/commit-id"
        commit_id = readFile('.git/commit-id').trim()
    }
    stage('Docker build/push') {
        docker.withRegistry('http://index.docker.io/v1', 'dockerhub') {
            def easyetlImage = docker.build("gleisonbs/easyetl:${commit_id}")
            easyetlImage.push()
            easyetlImage.push('latest')
        }
    }

}
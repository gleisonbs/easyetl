node {
    def app
    properties(
        [
            pipelineTriggers([pollSCM('*/5 * * * *')])
        ]        
    )
    stage('Clone Repository') {
        checkout scm
    }
    stage('Build Image') {
        app = docker.build("gleisonbs/easyetl")
    }
    stage('Unit Tests') {
        app.inside {
            sh 'source $(pipenv --venv)/bin/activate'
            sh 'python -m pytest tests/unit/'
        }
    }
    stage('Docker build/push') {
        docker.withRegistry('http://index.docker.io/v1', 'dockerhub') {
            easyetlImage.push("${env.BUILD_NUMBER}")
            easyetlImage.push('latest')
        }
    }

}
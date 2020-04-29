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
            sh 'python -m pytest tests/unit/'
        }
    }
    stage('Docker build/push') {
        docker.withRegistry('http://index.docker.io/v1', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
            app.push('latest')
        }
    }

}
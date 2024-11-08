pipeline {
  environment {
    registry = "manasaid1994/lbg-car-spring-app-started"
    registryCredential = "dockerhub_id"
    dockerImage = ""
    RUNSERVER = credentials('DOCKER_LOGIN')
  }
  agent any
  stages {
    stage("Build DOcker Image"){
      steps {
        script {
          dockerImage=docker.build(registry)
        }
      }
    }
    
    
    stage ("push to docker hub") {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push("${env.BUILD_NUMBER}")
            dockerImage.push("latest")
          }
        }
      }
    }

    stage("clean up"){
      steps{
        script{
          sh 'docker image prune --all --force --filter "until=48h"'
        }
      }
    }
    
  }
}

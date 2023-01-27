### bring up commands 
``` 
    docker build -t jenkinsk6 .  
    docker container run -d --add-host host.docker.internal:host-gateway --env-file=./K6/SmokeTestFramework/.env --name jenkinstest -p 8080:8080 jenkinsk6   
    docker container inspect jenkinstest
    docker exec jenkinstest tail echo /var/jenkins_home/secrets/initialAdminPassword
    
    # debug 
    docker exec -it jenkinstest /bin/sh
    
    # restart Jenknis after pluggins have been added.
    docker container stop jenkinstest
    docker container start jenkinstest

 ``` 

### tear down commands
``` 
    docker stop jenkinstest
    docker rm jenkinstest
    docker image rm jenkinsk6
 ```
 ```
pipeline {
agent any

    stages {
        stage('K6 Tests') {
            steps {
                sh '''../../../K6/SmokeTestFramework/testRunner.sh  true'''
            }
        }
    }
}
 ```
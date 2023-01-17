### bring up commands 
``` 
    docker build  -t jenkinsk6 .  
    docker container run -d --add-host host.docker.internal:host-gateway  --name jenkinstest -p 8080:8080 jenkinsk6
    
    docker exec jenkinstest tail echo /var/jenkins_home/secrets/initialAdminPassword
 ``` 

### tear down commands
``` 
    docker stop jenkinstest
    docker rm jenkinstest
    docker image rm jenkinsk6
 ``` 
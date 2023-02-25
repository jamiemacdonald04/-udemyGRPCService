# UdemyGRPCService
cd UdemyGRPCService

### run test
k6 run com.github.grpc/src/main/k6/test.js


### Coffee Ready Smoke Test
k6 run com.github.grpc/src/main/k6/CoffeeReadySmokeTest.js

### framework
k6 run ${SmokeTestFramework}/CoffeeReadySmokeTestPositive.js
k6 run ${SmokeTestFramework}/CoffeeReadySmokeTestSpecialChars.js
k6 run ${SmokeTestFramework}/CleanCoffeeMachineSmokeTestPositive.js
k6 run ${SmokeTestFramework}/CleanCoffeeMachineSmokeTestSpecialChars.js
k6 run ${SmokeTestFramework}/CoffeeReadyEmptyNameSmokeTest.js
k6 run ${SmokeTestFramework}/multipleStagedCallsMachineAudit.js
### Coffee Ready Soak Test
k6 run /com.github.grpc/src/main/k6/CoffeeReadySoakTest.js

### Coffee Ready Load Test
k6 run /com.github.grpc/src/main/k6/CoffeeReadyLoadTest.js

### Coffee Ready Smoke Test empty name 
k6 run ${SmokeTestFramework}/CoffeeReadyEmptyNameSmokeTest.js


### Coffee Ready spike Test
k6 run /com.github.grpc/src/main/k6/CoffeeReadySpikeTest.js

### multiple staged calls 
k6 run --env token="Bearer ${token}" com.github.grpc/src/main/K6/multipleStagedCallsMachineAudit.js
k6 run --no-summary --quiet=true --env token="Bearer ${token}" com.github.grpc/src/main/K6/SmokeTestFramework/multipleStagedCallsMachineAudit.js

### reuse and robust tests
k6 run com.github.grpc/src/main/K6/CoffeeReadySpikeReUseAndRobustTest.js
k6 run com.github.grpc/src/main/K6/CoffeeReadySpikeReUseConnectionPerUserAndRobustTest.js
k6 run com.github.grpc/src/main/K6/CoffeeReadySpikeReUseConnectionPerUserAndRandomInDataTest.js

### One of
k6 run com.github.grpc/src/main/K6/OrderOfMenuSmokeTest.js

###framework
chmod +x ${SmokeTestFramework}/testRunner.sh
./${SmokeTestFramework}/testRunner.sh false

###framework Parallel
chmod +x ${SmokeTestFrameworkParallel}/testRunner.sh
./${SmokeTestFrameworkParallel}/testRunner.sh false


###framework Parallel Quite Fast
chmod +x ${SmokeTestFrameworkParallelQuitFast}/testRunner.sh
./${SmokeTestFrameworkParallelQuitFast}/testRunner.sh false



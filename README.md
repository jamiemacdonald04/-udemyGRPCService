# UdemyGRPCService

cd UdemyGRPCService

### run test
k6 run /com.github.grpc/src/main/k6/test.js


### Coffee Ready Smoke Test
k6 run com.github.grpc/src/main/k6/CoffeeReadySmokeTest.js

### framework
k6 run /com.github.grpc/src/main/k6/SmokeTestFramework/CoffeeReadySmokeTestPositive.js
k6 run /com.github.grpc/src/main/k6/SmokeTestFramework/CoffeeReadySmokeTestSpecialChars.js
k6 run /com.github.grpc/src/main/k6/SmokeTestFramework/CleanCoffeeMachineSmokeTestPositive.js
k6 run /com.github.grpc/src/main/k6/SmokeTestFramework/CleanCoffeeMachineSmokeTestSpecialChars.js
k6 run /com.github.grpc/src/main/k6/SmokeTestFramework/CoffeeReadyEmptyNameSmokeTest.js
### Coffee Ready Soak Test
k6 run /com.github.grpc/src/main/k6/CoffeeReadySoakTest.js

### Coffee Ready Load Test
k6 run /com.github.grpc/src/main/k6/CoffeeReadyLoadTest.js

### Coffee Ready Smoke Test empty name 
k6 run /com.github.grpc/src/main/k6/CoffeeReadyEmptyNameSmokeTest.js

### Coffee Ready spike Test
k6 run /com.github.grpc/src/main/k6/CoffeeReadySpikeTest.js

### framework
chmod +x /com.github.grpc/src/main/k6/SmokeTestFramework/testRunner.sh
./com.github.grpc/src/main/k6/SmokeTestFramework/testRunner.sh true

./${testLocation}/testRunner.sh true

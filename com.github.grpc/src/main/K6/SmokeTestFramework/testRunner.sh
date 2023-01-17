#!/bin/bash

k6 run --no-summary --quiet=true UdemyGRPCService/com.github.grpc/src/main/k6/SmokeTestFramework/CoffeeReadySmokeTestPositive.js
k6 run --no-summary --quiet=true UdemyGRPCService/com.github.grpc/src/main/k6/SmokeTestFramework/CoffeeReadySmokeTestSpecialChars.js
k6 run --no-summary --quiet=true UdemyGRPCService/com.github.grpc/src/main/k6/SmokeTestFramework/CleanCoffeeMachineSmokeTestPositive.js
k6 run --no-summary --quiet=true UdemyGRPCService/com.github.grpc/src/main/k6/SmokeTestFramework/CleanCoffeeMachineSmokeTestSpecialChars.js
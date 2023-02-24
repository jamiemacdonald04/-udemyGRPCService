#!/bin/bash
set -e
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
basicAuth="${username}:${password}"
basicAuthBase64=$(echo -n "${basicAuth}" | base64)
tokenAuth="${token}"
resultsFile="${SmokeTestFrameworkParallel}/results.log"
displayNoColour=$1

runCleanUp() {
  fail=`grep -wc "FAILED!" ${resultsFile} || true`
  success=`grep -wc "OK!" ${resultsFile} || true`
  results=`cat ${resultsFile}`
  printf "${results} \n"
    if [[ ${displayNoColour} = true ]]
    then
      printf "Successful Calls ${success} || Failed Calls: ${fail} \n"
    else
      printf "${GREEN}Successful Calls ${success} ${NC} || ${RED}Failed Calls: ${fail} ${NC} \n"
    fi
  rm ${resultsFile}
  exit ${2}
}

k6Run(){
  k6 run --no-summary --quiet=true --env dataAnyInput="$2" --env token="Basic ${basicAuthBase64}" "$1" --console-output=${resultsFile} --address localhost:0
   #|| runCleanUp  74
}

spinner()
{
  pid=$! # Process Id of the previous running command
  spin='-\|/'
  i=0
  while kill -0 $pid 2>/dev/null
  do
    i=$(( (i+1) %4 ))
    printf "\r${spin:$i:1}"
    sleep .1
  done
}

testRunner(){
  set -e
  #k6Run "${SmokeTestFrameworkParallel}/FAILER.js"
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/FAILER.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/FAILER.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js"  &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js"  &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js"  &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &

  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js"  &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadySmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestPositive.js" &
  k6Run "${SmokeTestFrameworkParallel}/CleanCoffeeMachineSmokeTestSpecialChars.js" &
  k6Run "${SmokeTestFrameworkParallel}/CoffeeReadyEmptyNameSmokeTest.js"

  milks=`cd ${SmokeTestFrameworkParallel} && cat ../../TestData/milk.json`

  #echo -n ${milks} | jq -c '.milks[]' | while read milkIn; do
   # k6Run "${SmokeTestFrameworkParallel}/MakeCoffeeSmokeTestPositive.js" "${milkIn}" &
  #done
 # k6Run "${SmokeTestFrameworkParallel}/multipleStagedCallsMachineAudit.js"

  wait
}

testRunner & spinner && runCleanUp 0
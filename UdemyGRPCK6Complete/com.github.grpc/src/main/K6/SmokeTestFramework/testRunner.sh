#!/bin/bash
set -e
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
basicAuth="${username}:${password}"
basicAuthBase64=$(echo -n "${basicAuth}" | base64)
tokenAuth="${token}"
resultsFile="${SmokeTestFramework}/results.log"

runCleanUp() {

  fail=`grep -wc "FAILED!" ${resultsFile} || true`
  if [[ ${2} -gt 0 ]]
  then
    fail=1
  fi
  success=`grep -wc "OK!" ${resultsFile} || true`
  results=`cat ${resultsFile}`
  printf "${results} \n"

  if [[ ${1} = true ]]
  then
    printf "Successful Calls ${success} || Failed Calls: ${fail} \n"
  else
    printf "${GREEN}Successful Calls ${success} ${NC} || ${RED}Failed Calls: ${fail} ${NC} \n"
  fi
  rm ${resultsFile}
  exit ${2}
}

k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${SmokeTestFramework}/CoffeeReadySmokeTestPositive.js --console-output=${resultsFile}  || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Bearer ${basicAuthBase64}" ${SmokeTestFramework}/CoffeeReadySmokeTestSpecialChars.js --console-output=${resultsFile}   || runCleanUp  $1 74
#k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${SmokeTestFramework}/FAILER.js --console-output=${resultsFile}  || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${SmokeTestFramework}/CleanCoffeeMachineSmokeTestPositive.js --console-output=${resultsFile}   || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Bearer ${basicAuthBase64}" ${SmokeTestFramework}/CleanCoffeeMachineSmokeTestSpecialChars.js --console-output=${resultsFile}    || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${SmokeTestFramework}/CoffeeReadyEmptyNameSmokeTest.js --console-output=${resultsFile}    || runCleanUp $1 74

milks=`cd ${SmokeTestFramework} && cat ../../TestData/milk.json`
echo -n ${milks} | jq -c '.milks[]' | while read milkIn; do
  k6 run --no-summary --quiet=true --env dataAnyInput="${milkIn}" --env token="Basic ${basicAuthBase64}" ${SmokeTestFramework}/MakeCoffeeSmokeTestPositive.js --console-output=${resultsFile} || runCleanUp $1 74
done

k6 run --no-summary --quiet=true --env token="Bearer ${token}" com.github.grpc/src/main/K6/SmokeTestFramework/multipleStagedCallsMachineAudit.js --console-output=${resultsFile}  || runCleanUp $1 74

runCleanUp $1 0






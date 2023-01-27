#!/bin/bash
set -e
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
basicAuth="${username}:${password}"
basicAuthBase64=$(echo -n "${basicAuth}" | base64)
tokenAuth="${token}"
resultsFile="${testLocation}/results.log"

runCleanUp() {
  fail=`grep -wc "FAILED!" ${resultsFile} || true`
  if [[ ${2} -gt 0 ]]
  then
    fail=1
  fi
  success=`grep -wc "OK!" ${resultsFile}`
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

k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${testLocation}/CoffeeReadySmokeTestPositive.js --console-output=${resultsFile}  || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Bearer ${tokenAuth}" ${testLocation}/CoffeeReadySmokeTestSpecialChars.js --console-output=${resultsFile}  || runCleanUp  $1 74
#k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${testLocation}/FAILER.js --console-output=${resultsFile}  || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${testLocation}/CleanCoffeeMachineSmokeTestPositive.js --console-output=${resultsFile} || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Bearer ${tokenAuth}" ${testLocation}/CleanCoffeeMachineSmokeTestSpecialChars.js --console-output=${resultsFile}  || runCleanUp $1 74
k6 run --no-summary --quiet=true  --env token="Basic ${basicAuthBase64}" ${testLocation}/CoffeeReadyEmptyNameSmokeTest.js --console-output=${resultsFile}  || runCleanUp $1 74

#almondMilk=`cd ${testLocation} && cat ../../TestData/milk.json`
#k6 run --no-summary --quiet=true --env dataAnyInput="${almondMilk}" --env token="Basic ${basicAuthBase64}" ${testLocation}/MakeCoffeeSmokeTestPositive.js --console-output=${resultsFile} || runCleanUp $1 74

#fullFatMilk=`cd ${testLocation} && cat ../../TestData/FullfatMilk.json`


milks=`cd ${testLocation} && cat ../../TestData/milk.json`
echo -n ${milks} | jq -c '.milks[]' | while read milkIn; do
 k6 run --no-summary --quiet=true --env dataAnyInput="${milkIn}" --env token="Basic ${basicAuthBase64}" ${testLocation}/MakeCoffeeSmokeTestPositive.js --console-output=${resultsFile} || runCleanUp $1 74
done
runCleanUp $1 0

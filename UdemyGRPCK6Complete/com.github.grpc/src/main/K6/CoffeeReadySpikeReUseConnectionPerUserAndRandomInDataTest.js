import grpc from 'k6/net/grpc';
import {check, sleep} from 'k6';
import{Counter} from 'k6/metrics';
import exec from 'k6/execution';
import { randomIntBetween } from 'https://jslib.k6.io/k6-utils/1.2.0/index.js';
import { SharedArray } from 'k6/data';
import { CheckResultsThreshold } from './results.js'

const client = new grpc.Client();
client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

var retryCounter = 6;
var uniqueConnection;
const url=`${__ENV.url}`
const port=`${__ENV.port}`
const serviceName = "CoffeeReady"
const data = new SharedArray('users', function () {
  const file = JSON.parse(open('../TestData/CoffeeReadyData.json'));
  return file;
});

export const options = {
    stages: [
       {duration: "1m", target: 100}, // ramping up to the normal usage of our webservice
       {duration: "1m", target: 100}, // maintain normal capacity
       {duration: "3m", target: 3000}, // spike of users simulating denial of service attack
       {duration: "1m", target: 100}, // resume normal service
       {duration: "5m", target: 100}, // does our service recover as normal traffic here
    ],
    thresholds: {
        'Overall_Errors' : [{threshold: 'count<51', abortOnFail: true}],
    }
}

const counterErrors = new Counter('Overall_Errors')
const connectionsMade = new Counter('Connections_Made')

export default () => {
    try{
        if(uniqueConnection == undefined){
            uniqueConnection=createNewClient();
        }
        const response = invokeRequest(uniqueConnection)

        if (!CheckResultsThreshold(response, serviceName)){
               counterErrors.add(1)
        }

    }catch(err){
       handleError(err);
    }
}

function createNewClient(){
    try{
        if (retryCounter == 0) {
            exec.test.abort("too many connection attempts made.");
        }
        client.connect(url + ':' + port, {plaintext: true});
        connectionsMade.add(1);
        return client;
    }catch(err){
       handleError(err);
    }
}


function invokeRequest(uniqueConnectionForClient){
   try{
        return uniqueConnectionForClient.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', data[randomIntBetween(0, data.length-1)]);
    }catch(err){
        handleError(err);
    }
}

function handleError(err){
    console.error(err)
    counterErrors.add(1);
    retryCounter--
    createNewClient()
}
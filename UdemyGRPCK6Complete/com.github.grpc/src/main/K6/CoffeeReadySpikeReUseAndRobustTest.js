import grpc from 'k6/net/grpc';
import {check} from 'k6';
import{Counter} from 'k6/metrics';
import exec from 'k6/execution';

const client = new grpc.Client();
const params = {ClientName: "Jamie", Order : "White Coffee"};
client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');
var retryCounter = 6;
var url=`${__ENV.url}`
var port=`${__ENV.port}`

export const options = {
    stages: [
        {duration: "1m", target: 100}, // ramping up to the normal usage of our webservice
        {duration: "1m", target: 100}, // maintain normal capacity
        {duration: "3m", target: 3000}, // spike of users simulating denial of service attack
        {duration: "1m", target: 100},   // resume normal service
        {duration: "5m", target: 100},  // does our service recover as normal traffic here
    ],
}

const counterErrors = new Counter('Connection_Errors')

export default () => {
    getConnection();
    const response = invokeRequest()
    check(response, {
        'is ok' : (r) => r.status === grpc.StatusOK,
    });
}

function getConnection(retry){

    try{
        if (retryCounter == 0) {
            exec.test.abort("too many connection attempts made.");
        }

        if (__ITER != 0 && !retry) {
          return;
        }
        client.connect(url + ':' + port, {plaintext: true});

    }catch(err){
       handleError(err);
    }
}

function invokeRequest(){
   try{
        return client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', params);
    }catch(err){
        handleError(err);
    }
}

export function teardown(){
  client.close();
}

function handleError(err){
    console.error(err)
    counterErrors.add(1);
    retryCounter--
    getConnection(true)
}
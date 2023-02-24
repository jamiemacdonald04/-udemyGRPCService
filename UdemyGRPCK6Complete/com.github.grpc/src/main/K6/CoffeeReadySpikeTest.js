import grpc from 'k6/net/grpc';
import {check} from 'k6';
import{Counter} from 'k6/metrics';

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

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

    const params = {ClientName: "Jamie", Order : "White Coffee"};

    try{
        client.connect('localhost:50052', {

            plaintext: true,

        });
    }catch(err){
        console.error(err)
        counterErrors.add(1);
    }

    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', params);

    check(response, {

        'is ok' : (r) => r.status === grpc.StatusOK,

    });
    client.close();

}
import grpc from 'k6/net/grpc';
import {check} from 'k6';

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export const options = {
    stages: [
        {duration: "1m", target: 100},  // we are ramping up to 100 users over 1m
        {duration: "5m", target: 100}, // maintaining 100 users over 5 mins
        {duration: "10m", target: 500}, // ramping up from 100 users to 500 for 10 mins
        {duration: "1m", target: 500}, // hold 500 users 1min
        {duration: "5m", target: 100}, // ramping down to 100 users over a period of 5m
        {duration: "5m", target: 0},  // ticket office closing so we are ramping down to 0 over a period of 5 mins.
    ]
}

export default () => {


    client.connect('localhost:50051', {

        plaintext: true,

    });

    const params = {ClientName: "Jamie", Order : "White Coffee"};

    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', params);


    check(response, {

        'is ok' : (r) => r.status === grpc.StatusOK,

    });

    client.close();

}
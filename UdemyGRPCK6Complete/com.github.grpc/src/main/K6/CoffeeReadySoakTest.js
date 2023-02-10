import grpc from 'k6/net/grpc';
import {check} from 'k6';

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export const options = {
    stages: [
        {duration: "3m", target: 200},
        {duration: "4h3m", target: 200},
        {duration: "3m", target: 0}
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
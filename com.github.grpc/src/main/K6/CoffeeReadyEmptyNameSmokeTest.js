import grpc from 'k6/net/grpc';
import {check} from 'k6';

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {


    client.connect('localhost:50051', {

        plaintext: true,

    });

    const params = {ClientName: "", Order : "White Coffee"};

    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', params);


    check(response, {

        'is ok' : (r) => r.status === grpc.StatusOK,

    });

    console.log(JSON.stringify(response.message));

    client.close();

}
import grpc from 'k6/net/grpc';
import {check} from 'k6';
import { describe } from 'https://jslib.k6.io/expect/0.0.4/index.js';

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {


    client.connect('localhost:50051', {

        plaintext: true,

    });

    // const params = {"menuItem":"Latte"};
    const params = {"menuItemID":"43"};

    describe('make assertions on our coffee order gRPC Service', (t) =>{

        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/OrderOfMenu', params);

        console.log(response);

        t.expect(Number(response.status))
        .as("status is ok")
        .toEqual(Number(grpc.StatusOK));
    })
/*
    check(response, {
        'status is ok' : (result) => result.status === grpc.StatusOK
    });
    */

    client.close();

}
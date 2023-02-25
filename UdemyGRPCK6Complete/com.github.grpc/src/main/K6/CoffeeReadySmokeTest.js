import grpc from 'k6/net/grpc';
import {check} from 'k6';
import { describe } from 'https://jslib.k6.io/expect/0.0.4/index.js';

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {
    var url=`${__ENV.url}`
    var port=`${__ENV.port}`
    client.connect(url + ':' + port, {plaintext: true});
    var name = "Jamie";
    var order = "White Coffee";
    const params = {ClientName: name, Order : order};
    describe('make assertions on our coffee order gRPC Service', (t) =>{
        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', params);
        console.log(response);
        t.expect(Number(response.status))
        .as("status is ok")
        .toEqual(Number(grpc.StatusOK))
        .and(response.message.ready.length)
        .toBeGreaterThanOrEqual(56);
    })
/*
    check(response, {
        'status is ok' : (result) => result.status === grpc.StatusOK,
        'Message is not blank' : (result) => result.message.ready != "",
        'are only two headers' : (result) => Object.keys(result.headers).length === 2,
        'error is null ' : (result) => result.error == null,
        'arguments are in results' : (result) => JSON.stringify(result.message.ready).includes(name)  && JSON.stringify(result.message.ready).includes(order),
        'trailers are empty ' : (result) => Object.keys(result.trailers).length === 0,
    });
    */
    client.close();
}
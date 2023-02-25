import grpc from 'k6/net/grpc';
import {check} from 'k6';

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {
    var url=`${__ENV.url}`
    var port=`${__ENV.port}`
    client.connect(url + ':' + port, {plaintext: true});
    const params = {ClientName: "", Order : "White Coffee"};
    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', params);
    check(response, {
        'is ok' : (r) => r.status === grpc.StatusOK,
    });
    console.log(response);
    client.close();

}
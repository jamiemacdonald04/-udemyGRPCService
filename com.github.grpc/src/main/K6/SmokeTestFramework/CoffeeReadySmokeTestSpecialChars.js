import grpc from 'k6/net/grpc';
import {check} from 'k6';

const client = new grpc.Client();

client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {


    client.connect('localhost:50051', {

        plaintext: true,

    });
    var name = "Jami'!@£$%^&*())0-_+=e";
    var order = "Jami'!@£$%^&*())0-_+=e";

    const params = {ClientName: name, Order : order};


    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CoffeeReady', params);


    check(response, {
        'status is ok' : (result) => result.status === grpc.StatusOK,
    });

    client.close();

}
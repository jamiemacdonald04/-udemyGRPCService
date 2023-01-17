import grpc from 'k6/net/grpc';
import {check} from 'k6';

const client = new grpc.Client();

client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {


    client.connect('localhost:50051', {

        plaintext: true,

    });

      var coffeeMachineName = "Coffee Machi'!@£$%^&*()_-+=ne Two";
      var cleaningMode = "Deep '!@£$%^&*()_-+=Clean";

    const params = {name: coffeeMachineName, cleanMode : cleaningMode};


    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/CleanCoffeeMachine', params);

    check(response, {
        'status is ok' : (result) => result.status === grpc.StatusOK,
    });


    client.close();

}
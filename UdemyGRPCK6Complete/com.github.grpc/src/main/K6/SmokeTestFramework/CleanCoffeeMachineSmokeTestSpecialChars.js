import grpc from 'k6/net/grpc';
import { CheckResults } from '../results.js'

const client = new grpc.Client();

client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {

    var authorization=`${__ENV.token}`
    var url=`${__ENV.url}`
    var port=`${__ENV.port}`
    var serviceName = "CleanCoffeeMachine"
    var coffeeMachineName = "Coffee Machi'!@£$%^&*()_-+=ne Two";
    var cleaningMode = "Deep '!@£$%^&*()_-+=Clean";

    const meta = {
        metadata: {
         "Authorization" : authorization
        }
    }

    client.connect(url + ':' + port, {

        plaintext: true,

    });


    const params = {name: coffeeMachineName, cleanMode : cleaningMode};


    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params);

   CheckResults(response, serviceName)

    client.close();

}
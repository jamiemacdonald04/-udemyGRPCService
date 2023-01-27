import grpc from 'k6/net/grpc';
import { CheckResults } from '../results.js'

const client = new grpc.Client();

client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {

    var authorization=`${__ENV.token}`
    var url=`${__ENV.url}`
    var port=`${__ENV.port}`
    var serviceName = "CoffeeReady"
    var name = "Jamie";
    var order = "White Coffee";

    const meta = {
        metadata: {
         "Authorization" : authorization
        }
    }

    client.connect(url + ':' + port, {

        plaintext: true,

    });

    const params = {ClientName: name, Order : order};


    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params);


   CheckResults(response, serviceName)

    client.close();

}
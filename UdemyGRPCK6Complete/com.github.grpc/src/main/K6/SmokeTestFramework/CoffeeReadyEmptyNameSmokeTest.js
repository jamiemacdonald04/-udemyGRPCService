import grpc from 'k6/net/grpc';
import {check} from 'k6';
import { CheckResultsFail } from '../results.js'

const client = new grpc.Client();

client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {

    var authorization=`${__ENV.token}`
    var url=`${__ENV.url}`
    var port=`${__ENV.port}`
    var serviceName = "CoffeeReady";

    const meta = {
        metadata: {
         "Authorization" : authorization
        }
    }

    client.connect(url + ':' + port, {

        plaintext: true,

    });

    const params = {ClientName: "", Order : "White Coffee"};

    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params);

   CheckResultsFail(response, serviceName)

    client.close();

}
import grpc from 'k6/net/grpc';
import {check} from 'k6';
import { CheckResultsPassOrFail } from './results.js'

const client = new grpc.Client();
client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {
    var serviceName = "CoffeeReady";
    try{
        var authorization=`${__ENV.token}`
        var url=`${__ENV.url}`
        var port=`${__ENV.port}`
        const meta = {
            metadata: {
             "Authorization" : authorization
            }
        }
        client.connect(url + ':' + port, { plaintext: true});
        const params = {ClientName: "", Order : "White Coffee"};
        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params);
        CheckResultsPassOrFail(response, serviceName)
        client.close();
    }catch(err){
        console.log("The service/test with a possible syntax/runtime error with service name " + serviceName + " has FAILED!");
    }
}
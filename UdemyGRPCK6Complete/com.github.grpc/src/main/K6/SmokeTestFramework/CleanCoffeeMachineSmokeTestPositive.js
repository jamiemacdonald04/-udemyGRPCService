import grpc from 'k6/net/grpc';
import { CheckResults } from './results.js'

const client = new grpc.Client();
client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export default () => {
   var serviceName = "CleanCoffeeMachine"
   try{
        var authorization=`${__ENV.token}`
        var url=`${__ENV.url}`
        var port=`${__ENV.port}`
        var coffeeMachineName = "Coffee Machine Two";
        var cleaningMode = "Deep Clean";
        const meta = {
            metadata: {
             "Authorization" : authorization
            }
        }
        client.connect(url + ':' + port, {
            plaintext: true,
        });
        const params = {name: coffeeMachineName, cleanMode : cleaningMode};
        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params, meta);
        CheckResults(response, serviceName)
        client.close();
    }catch(err){
        console.log("The service/test with a possible syntax/runtime error with service name " + serviceName + " has FAILED!");
    }
}
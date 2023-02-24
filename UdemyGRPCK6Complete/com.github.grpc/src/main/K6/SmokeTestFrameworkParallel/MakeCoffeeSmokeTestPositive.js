import grpc from 'k6/net/grpc';
import { CheckResultsPassOrFail } from './results.js'

const client = new grpc.Client();
client.load(['../../proto/theBusyBean','../../proto/anyTypes'], 'CoffeeMaker.proto','AlmondMilk.proto','FullFatMilk.proto');

export default () => {
    var serviceName = "MakeCoffee"
    try{
        var authorization=`${__ENV.token}`
        var url=`${__ENV.url}`
        var port=`${__ENV.port}`
        var data=JSON.parse(`${__ENV.dataAnyInput}`);
        const meta = {
            metadata: {
             "Authorization" : authorization
            }
        }
        client.connect(url + ':' + port, { plaintext: true });
        var prefix = "name>" + data.milk.name + "| ingredients>" + data.ingredients
        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, data, meta);
        CheckResultsPassOrFail(response, serviceName, prefix)
        client.close();
    }catch(err){
        console.log("The service/test with a possible syntax/runtime error with service name " + serviceName + " has FAILED!");
    }

}
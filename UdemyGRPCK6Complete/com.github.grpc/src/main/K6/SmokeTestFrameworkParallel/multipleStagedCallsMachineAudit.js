import { describe as step, it } from "https://cdn.jsdelivr.net/npm/kahwah";
import grpc from 'k6/net/grpc';
import {CheckResultsPassOrFail} from './results.js';
export{options, default} from "https://cdn.jsdelivr.net/npm/kahwah";

var authorization=`${__ENV.token}`;
var url=`${__ENV.url}`;
var port=`${__ENV.port}`;

const client = new grpc.Client();
client.load(['../../proto/theBusyBean'], 'CoffeeMaker.proto');

export function setup(){
    const meta = {
        metadata: {
         "Authorization" : authorization
        }
    };
    return { session: {meta}};
}

step("clean coffee machine", (ctx) => {
    var serviceName = "CleanCoffeeMachine"
    try{
        const {meta} = ctx.session;
        var coffeeMachineName = "Coffee Machine Two";
        var cleaningMode = "Deep Clean";
        client.connect(url + ':' + port, { plaintext: true });
        const params = {name: coffeeMachineName, cleanMode : cleaningMode};
        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params, meta);
        CheckResultsPassOrFail(response, serviceName + "/Multiple Staged Calls Machine Audit (step 1)")
        ctx.session.params = response.message.result;
        client.close();
    }catch(err){
        console.log("The service/test with a possible syntax/runtime error with service name " + serviceName + " has FAILED!");
    }
});

step("Machine Audit", (ctx) => {
    var serviceName = "MachineAudit"
    try{
        const {meta, params} = ctx.session;
        client.connect(url + ':' + port, { plaintext: true });
        const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params, meta);
        CheckResultsPassOrFail(response, serviceName + "/Multiple Staged Calls Machine Audit (step 2)")
        client.close();
    }catch(err){
        console.log("The service/test with a possible syntax/runtime error with service name " + serviceName + " has FAILED!");
    }
});

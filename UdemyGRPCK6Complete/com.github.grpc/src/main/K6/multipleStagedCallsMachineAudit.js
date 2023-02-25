import { describe as step, it } from "https://cdn.jsdelivr.net/npm/kahwah";
import grpc from 'k6/net/grpc';
import {CheckResults} from './results.js';

export{options, default} from "https://cdn.jsdelivr.net/npm/kahwah";

var authorization=`${__ENV.token}`;
var url=`${__ENV.url}`;
var port=`${__ENV.port}`;

const client = new grpc.Client();

client.load(['../proto/theBusyBean'], 'CoffeeMaker.proto');

export function setup(){
    const meta = {
        metadata: {
         "Authorization" : authorization
        }
    };

    return { session: {meta}};
}

step("clean coffee machine", (ctx) => {
    const {meta} = ctx.session;
    var serviceName = "CleanCoffeeMachine"
    var coffeeMachineName = "Coffee Machine Two";
    var cleaningMode = "Deep Clean";

    client.connect(url + ':' + port, {plaintext: true});
    const params = {name: coffeeMachineName, cleanMode : cleaningMode};
    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params, meta);
    CheckResults(response, serviceName)
    ctx.session.params = response.message.result;
    client.close();
});

step("Machine Audit", (ctx) => {
    const {meta, params} = ctx.session;
    var serviceName = "MachineAudit"

    client.connect(url + ':' + port, {
        plaintext: true,
    });

    const response = client.invoke('test.logic.CoffeeMaker.CoffeeShopService/' + serviceName, params, meta);
    CheckResults(response, serviceName)
    client.close();
});

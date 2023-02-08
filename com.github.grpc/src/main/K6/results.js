import grpc from 'k6/net/grpc';
import {check} from 'k6';
import exec from 'k6/execution'

export function CheckResults(response, serviceName, prefixData){
    var prefix = "";
    if(prefixData){
        prefix="(" + prefixData + ")"
    }
    check(response, {
        'status is ok' : (result) => result.status === grpc.StatusOK,
    });

    if(response.status != grpc.StatusOK){
      exec.test.abort(prefix + "The service " + serviceName + " FAILED!")
      console.log(response)
    }
    console.log(prefix + "The service " + serviceName + " executed OK!" )
}

export function CheckResultsFail(response, serviceName, prefixData){
    var prefix = "";
    if(prefixData){
        prefix="(" + prefixData + ")"
    }

    check(response, {
        'status is ok' : (result) => result.status === grpc.StatusOK,
    });

    if(response.status === grpc.StatusOK){
      exec.test.abort(prefix + "The service " + serviceName + " has passed therefore the test FAILED!")
      console.log(response)
      return;
    }
    console.log(prefix + "The service " + serviceName + " failed and was test pass OK!" )
}

export function CheckResultsThreshold(response, serviceName, prefixData){
    var prefix = "";
    if(prefixData){
        prefix="(" + prefixData + ")"
    }
    check(response, {
        'status is ok' : (result) => result.status === grpc.StatusOK,
    });

    if(response.status != grpc.StatusOK){
        console.error(response.error);
        return false;
    }
    return true;
}



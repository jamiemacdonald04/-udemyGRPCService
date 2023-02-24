import grpc from 'k6/net/grpc';
import {check} from 'k6';
import exec from 'k6/execution'

// this method runs the pass and fail check for our framework.
export function CheckResultsPassOrFail(response, serviceName, prefixData, errorType){
    var prefix = "";
    if (prefixData) {
        prefix="(" + prefixData + ")"
    };
    check(response, {
        'status is ok' : (result) => errorType != null? Number(result.status) === Number(errorType):response.status === grpc.StatusOK,
    });
    // good new pass
    if (response.status === grpc.StatusOK) {
        console.log(prefix + "The service " + serviceName + " executed OK!" );
        return
    }
    // good news fail
    if(errorType != null){
        if (Number(response.status) === Number(errorType)) {
            console.log(prefix + "The service " + serviceName + " had an expected failure (code:" + errorType + ") and is OK!" );
            return;
        }
    }
    console.log(prefix + "The service " + serviceName + " FAILED!");
    return;
}

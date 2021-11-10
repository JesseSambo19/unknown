import ballerina/grpc;

public isolated client class FunctionClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR, getDescriptorMap());
    }

    isolated remote function Create_function(FunctionRequest|ContextFunctionRequest req) returns (FunctionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        FunctionRequest message;
        if (req is ContextFunctionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("grpc_service.Function/Create_function", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <FunctionResponse>result;
    }

    isolated remote function Create_functionContext(FunctionRequest|ContextFunctionRequest req) returns (ContextFunctionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        FunctionRequest message;
        if (req is ContextFunctionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("grpc_service.Function/Create_function", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <FunctionResponse>result, headers: respHeaders};
    }
}

public client class FunctionFunctionResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendFunctionResponse(FunctionResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextFunctionResponse(ContextFunctionResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextFunctionRequest record {|
    FunctionRequest content;
    map<string|string[]> headers;
|};

public type ContextFunctionResponse record {|
    FunctionResponse content;
    map<string|string[]> headers;
|};

public type FunctionRequest record {|
    string firstname = "";
    string lastname = "";
    string email = "";
|};

public type FunctionResponse record {|
    string userid = "";
|};

const string ROOT_DESCRIPTOR = "0A0E66756E6374696F6E2E70726F746F120C677270635F7365727669636522610A0F46756E6374696F6E52657175657374121C0A0966697273746E616D65180120012809520966697273746E616D65121A0A086C6173746E616D6518022001280952086C6173746E616D6512140A05656D61696C1803200128095205656D61696C222A0A1046756E6374696F6E526573706F6E736512160A067573657269641801200128095206757365726964325C0A0846756E6374696F6E12500A0F4372656174655F66756E6374696F6E121D2E677270635F736572766963652E46756E6374696F6E526571756573741A1E2E677270635F736572766963652E46756E6374696F6E526573706F6E7365620670726F746F33";

isolated function getDescriptorMap() returns map<string> {
    return {"function.proto": "0A0E66756E6374696F6E2E70726F746F120C677270635F7365727669636522610A0F46756E6374696F6E52657175657374121C0A0966697273746E616D65180120012809520966697273746E616D65121A0A086C6173746E616D6518022001280952086C6173746E616D6512140A05656D61696C1803200128095205656D61696C222A0A1046756E6374696F6E526573706F6E736512160A067573657269641801200128095206757365726964325C0A0846756E6374696F6E12500A0F4372656174655F66756E6374696F6E121D2E677270635F736572766963652E46756E6374696F6E526571756573741A1E2E677270635F736572766963652E46756E6374696F6E526573706F6E7365620670726F746F33"};
}


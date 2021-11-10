import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR, descMap: getDescriptorMap()}
service "Function" on ep {

    remote function Create_function(FunctionRequest value) returns FunctionResponse|error {
        io:println("received an RPC request from a client...");
    }
}


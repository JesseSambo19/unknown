FunctionClient ep = check new ("http://localhost:9090");

public function main() returns error? {
  io:println("about to send an RPC request to server");

  FunctionRequest = {fullName: "Jesse Sambo", email: "jessesambo487@gmail.com", language: "ballerina", function: new_fn};

  json res = check ep -> 
}


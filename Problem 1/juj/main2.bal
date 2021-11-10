import ballerina/http;
import ballerina/io;

type Student record {
    string Name;
    int Grade;
};

json readJson = {};
Student[] all_users = [];
string jsonFilePath = "./files/jsonFile.json";
json jsonContent = {"Store": {
            "@id": "AST", 
            "name": "Anne", 
            "address": {
                "street": "Main", 
                "city": "94"
            }, 
            "codes": ["4", "8"]
        }};

service /hello on new http:Listener(9090) {
    @http:ResourceConfig {
        consumes: ["application/json"]
    }

    resource function post bindStudent(@http:Payload Student student) returns json|error {
        string name = student.Name;
        int Grade = student.Grade;
        string jsonFilePath = "./files/jsonFile.json";
        json jsonContent = {"Store": {
            "@id": "AST", 
            "name": "Anne", 
            "address": {
                "street": "Main", 
                "city": "94"
            }, 
            "codes": ["4", "8"]
        }};
        check io:fileWriteJson(jsonFilePath, jsonContent);
        return {Grade: Grade};

    }
    resource function get all() returns Student[]|error|json {
        io:println("handling GET request to /users/all");
        readJson = check io:fileReadJson(jsonFilePath);
        io:println(readJson);
        //jsonContent=readJson;
        return readJson;
    }
    function write() returns error? {

    }
    public function read() returns error? {
        json readJson = check io:fileReadJson(jsonFilePath);
        io:println(readJson);
    }

    @http:ResourceConfig {
        consumes: ["application/xml"]
    }
    resource function post bindXML(@http:Payload xml store) returns xml {
        xml city = store.selectDescendants("{http://www.test.com}city");
        return city;
    }
}

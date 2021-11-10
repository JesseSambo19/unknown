import ballerina/http;
import ballerina/io;


string jsonStudentFilePath = "./files/students.json";
string jsonFilePath="./files/course.json";

type Learner record {|
string id;
    string username;
    string firstname;
    string lastname?;
    string[] preferred_formats;
    json[] past_subjects; 
 

|};


type LearnerArray Learner[];

service /VLE on new http:Listener(9090) {
    @http:ResourceConfig {
        consumes: ["application/json"]
    }

    resource function post insertStudent(@http:Payload json data) returns string|error {
    
     
      
       json|io:Error readStudents = check io:fileReadJson(jsonStudentFilePath);
        json[] Students = check readStudents.ensureType();
      

        Students.push(data);
        check io:fileWriteJson(jsonStudentFilePath, Students);
        return "Student was saved";
       
    }
      resource function get all_students() returns error|json {
      map<json>[] newArr = [];
    json[] shoeGame = [];
    json|io:Error readJson = check io:fileReadJson(jsonStudentFilePath);

        json[] subjects = check readJson.ensureType();

   json[] arr =     check readJson.ensureType();


    Learner[] LearnerArr = check arr.cloneWithType();

    foreach Learner value in LearnerArr {
    string id = value.id; 
    
        
            string name = value.firstname;

            string? lastName = value?.lastname;

            if lastName is string {
                name += " " + lastName;
            }

            shoeGame= value.past_subjects;

            map<json> newLearner = {
                name
            };
        newLearner["id"] = value.id;
          newLearner["username"] = value.username;
        newLearner["past_subjects"] = shoeGame;
        

            newArr.push(newLearner);
        }


    return newArr;
    }
     resource function post student_details(string learner_id) returns error|json {
      map<json>[] newArr = [];
    json[] shoeGame = [];
    json[] formt = [];
    json|io:Error readJson = check io:fileReadJson(jsonStudentFilePath);

        json[] subjects = check readJson.ensureType();

   json[] arr =     check readJson.ensureType();


    Learner[] LearnerArr = check arr.cloneWithType();

    foreach Learner value in LearnerArr {
    string id = value.username; 
    if (id==learner_id) {
        
            string name = value.firstname;

            string? lastName = value?.lastname;

            if lastName is string {
                name += " " + lastName;
            }

            shoeGame= value.past_subjects;
 formt= value.preferred_formats;
            map<json> newLearner = {
                name
            };
        newLearner["id"] = value.id;
        newLearner["past_subjects"] = shoeGame;
        newLearner["preferred_formats"] = formt;

            newArr.push(newLearner);}
        }

    
    return newArr;
    }
    resource function get all_courses() returns error|json {
          io:println("handling GET request to /VLE/courses_all");
        json|io:Error readJson = check io:fileReadJson(jsonFilePath);
        json[] subjects = check readJson.ensureType();
        io:println(subjects);
         return subjects;
    }

    @http:ResourceConfig {
        consumes: ["application/xml"]
    }
    resource function post bindXML(@http:Payload xml store) returns xml {
        xml city = store.selectDescendants("{http://www.test.com}city");
        return city;
    }
}

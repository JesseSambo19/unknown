import ballerina/io;
import ballerina/http;
import ballerina/uuid;


type User record {
    string username;
    string lastname;
    string firstname;
    string[] preferred_formats;
    string[] past_subjects;
};

type Course record {
    string key;
    string course;
    Learning_objects learning_objects;
};

type Learning_objects record {
    Required required;
//  Sugessted sugessted;
};

type Required record {
    json[] audio;
    json[] text;
    json[] video;
};

type Sugessted record {
    map<json> audio;
    map<json> text;
    map<json> video;
};

type Topics record {
    string name;
    string description;
    string difficulty;
};

final http:Client clientEndpoint1 = check new ("http://localhost:9090/VLE/all_courses");

public function main(string... args) returns error? {
    json[]|() viewResult = check view();
    
}

public function startApp() returns error? {
    any choice;
    boolean lcv = true;
    while lcv == true {
        choice = io:readln("********************************\nMenu\n1:Insert\n2:Update\n3:View\n4:Exit\n********************************\n");
        match choice {
            "1" => {
                any in_choice;
                boolean in_lcv = true;
                while in_lcv == true {
                    in_choice = io:readln("********************************\nInsert Menu\n1:Student\n2:Course\n3:Back to Menu\n********************************\n");
                    match in_choice {
                        "1" => {
                            error? insertResult = insert("1");
                        }
                        "2" => {
                            error? insertResult = insert("1");
                            if insertResult is error {

                            }
                        }
                        "3" => {
                            in_lcv = false;
                        }

                    }
                }

            }
            "2" => {
                any upd_choice;
                boolean upd_lcv = true;
                while upd_lcv == true {
                    upd_choice = io:readln("********************************\nInsert Menu\n1:Student\n2:Course\n3:Back to Menu\n********************************\n");
                    match upd_choice {
                        "1" => {

                        }
                        "2" => {

                        }
                        "3" => {
                            upd_lcv = false;
                        }

                    }
                }

            }
            "3" => {
                json[]|() viewResult = check view();
            }
            "4" => {
                io:println("Bye bye !!!!!!!!!!!");
                lcv = false;
            }
        }
    }
}

# Description
#
# + in_type - Parameter Description
# + return - Return Value Description  
public function insert(any in_type) returns error? {

    io:println(in_type);

    boolean in_lcv = true;
    boolean pref_found = false;
    map<json> student = {
        username: "", 
        lastname: "", 
        firstname: "", 
        preferred_formats: [], 
        past_subjects: []
    };

    // uuid1String
    string username = "";
    string lastname = "";
    string firstname = "";
    string[] preferred_formats = [];
    string[] past_subjects = [];
    //======================================Student record definition=============================================================

    match in_type {
        "1" => {

            lastname = io:readln("Enter students last name:");
            firstname = io:readln("Enter students first name:");
            username = firstname + "_" + lastname;
            while in_lcv == true {
                any preferred_formats_choice = io:readln("********************************\nAdd prefered format\n1:Audio\n2:Video\n3:Text\n4:Done adding\n********************************\n");
                match preferred_formats_choice {
                    "1" => {
                        foreach var preferred_format in preferred_formats {
                            if (preferred_format == "audio") {
                                pref_found = true;
                            }
                        }
                        if (pref_found == false) {
                            preferred_formats.push("audio");
                        } else {
                            io:println("Format is aready set for the student\n");
                        }
                    }
                    "2" => {
                        foreach var preferred_format in preferred_formats {
                            if (preferred_format == "video") {
                                pref_found = true;
                            }
                        }
                        if (pref_found == false) {
                            preferred_formats.push("video");
                        } else {
                            io:println("Format is aready set for the student\n");
                        }
                    }
                    "3" => {
                        foreach var preferred_format in preferred_formats {
                            if (preferred_format == "text") {
                                pref_found = true;
                            }
                        }
                        if (pref_found == false) {
                            preferred_formats.push("texts");
                        } else {
                            io:println("Format is aready set for the student\n");
                        }
                    }
                    "4" => {
                        in_lcv = false;
                    }
                }
            }

        }
        "2" => {

        }
    }
string uuid1String = uuid:createType1AsString();
    json j =  {id:uuid1String,username: username, lastname: lastname, firstname: firstname, preferred_formats: preferred_formats, past_subjects: check get_course()};

   error? sendData = send_data(j);
}

public function get_course() returns json[]|error? {

    http:Client clientEndpoint = check new ("http://localhost:9090/VLE/all_courses");
    json[] courses = check clientEndpoint->get("");
    json[] subjects = check courses.ensureType();
    json[] newArr = [];
    boolean lcv = true;
    foreach var item in subjects {
        lcv = true;
        while (lcv == true) {
            io:print(item.course);
            json|error course_name = item.course;
            any choice = io:readln("\n1:Add\n2:Skip\n");
            match choice {
                "1" => {
                    string grade = io:readln("What was your grade\n");
                    lcv = false;
                    json j = {
                        course: check item.course, 
                        grade: grade
};
                    newArr.push(j);
                }
                "2" => {
                    lcv = false;
                }
            }

        }
    }
    return newArr;
}

public function send_data(json data) returns error? {

    json msg = data;
    string s = msg.toJsonString();
    io:println(data);
    io:println("\nSaving data");
    http:Client clientEndpoint = check new ("http://localhost:9090/VLE/insertStudent");
    string res = check clientEndpoint->post("", msg);
   // json[] subjects = check courses.ensureType();
    
    io:println("\n",res);

}

public function update(int upd_type) {
    any choice;
    boolean lcv = true;
    while lcv == true {
        choice = io:readln("********************************\nUpdate Menu\n1:Student\n2:Course\n3:Back to Menu\n********************************");
        match choice {
            "1" => {

            }
            "2" => {

            }
            "3" => {
                lcv = false;
            }

        }
    }
}

public function view() returns json[]|error? {
    http:Client clientEndpoint = check new ("http://localhost:9090/VLE/student_details");
    string msg = io:readln("\nEnter student name you would want to view\n");
    io:println(msg);
    string res = check clientEndpoint->post("", msg);
    
 io:println(res);

}

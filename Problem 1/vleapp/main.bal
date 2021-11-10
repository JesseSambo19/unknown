import ballerina/io;

type User record {
    string username;
    string lastname;
    string firstname;
    string[] preferred_formats;
    string[] past_subjects;
};

public function main(string... args) {
    any choice;
    boolean lcv = true;
    while lcv == true {
        choice = io:readln("********************************\nMenu\n1:Insert\n2:Update\n3:View\n4:Exit\n********************************");
        match choice {
            "1" => {
                any in_choice;
                boolean in_lcv = true;
                while in_lcv == true {
                    in_choice = io:readln("********************************\nInsert Menu\n1:Student\n2:Course\n3:Back to Menu\n********************************");
                    match in_choice {
                        "1" => {
                            insert("1");
                        }
                        "2" => {
                            insert("1");
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
                    upd_choice = io:readln("********************************\nInsert Menu\n1:Student\n2:Course\n3:Back to Menu\n********************************");
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
                view();
            }
            "4" => {
                io:println("Bye bye !!!!!!!!!!!");
                lcv = false;
            }
        }
    }
}

# Description

public function insert(any in_type) {

    io:println(in_type);
    any in_choice;
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
                any preferred_formats_choice = io:readln("********************************\nAdd prefered format\n1:Audio\n2:Video\n3:Text\n4:Done adding\n********************************");
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
                            io:println("Format is aready set for the student");
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
                            io:println("Format is aready set for the student");
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
                            io:println("Format is aready set for the student");
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

    json j = {user: {username: username, lastname: lastname, firstname: firstname, preferred_formats: preferred_formats, past_subjects: past_subjects}};

    io:print(j);
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

public function view() {
    io:println("you picked view");
}

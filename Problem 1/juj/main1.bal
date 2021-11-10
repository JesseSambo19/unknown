import ballerina/io;



type Person record {|
    boolean employed;
    string first_name;
    string last_name?;
    Address? address;
|};

type Address record {
    string city;
    string country;
};

type PersonArray Person[];

public function main() returns error? {
    map<json>[] newArr = [];

    // Convert the JSON array to a `Person` record array.
    // `value:cloneWithType` accepts an argument to indicate
    // the `typedesc` with which the conversion should happen.
    // If not specified, it is inferred from the contextually-expected type.
    // The following is the same as saying
    // `Person[] personArr = check arr.cloneWithType(PersonArray);`
    Person[] personArr = check arr.cloneWithType();

    foreach Person value in personArr {
        // Since the `employed` field is defined to be a required field 
        // of type `boolean` in the `Person` record we can directly
        // use field access and use the value as a `boolean`.
        if !value.employed {
            continue;
        }

        // Use field access to directly access the `first_name` field
        // of type `string`.
        string name = value.first_name;

        // Since `last_name` is an optional field, use optional field access
        // to access the field.
        // If the field is present the value is guaranteed to be of type `string`.
        // Optional field access will return `()` (nil) if the field is not present.
        string? lastName = value?.last_name;

        if lastName is string {
            name += " " + lastName;
        }

        map<json> newPerson = {
            name
        };

        // Use field access to directly access the `address` field
        // of type `Address?`.
        Address? addressValue = value.address;

        if addressValue is () {
            newArr.push(newPerson);
            continue;
        }

        // This cast is safe since the nil case is already handled.
        Address address = <Address>addressValue;

        newPerson["city"] = address.city;
        newPerson["country"] = address.country;
        newArr.push(newPerson);
    }

    io:println(newArr); // Prints `[{"name":"Ayra","city":"Kandy","country":"Sri Lanka"},{"name":"Nilu Peiris"}]`
}

// This array could be retrieved as the payload of a request/response, read
// from a file, etc.
json[] arr = [
    {
    "first_name": "Radha",
    "address": {
        "apartment_no": 123,
        "street": "Perera Mawatha",
        "city": "Colombo",
        "country": "Sri Lanka"
    },
    "employed": true
}, 
    {
    "first_name": "Ayra",
     "last_name": "Peiris",
    "address": {
        "apartment_no": 11,
        "street": "Main Street",
        "city": "Kandy",
        "country": "Sri Lanka"
    },
    "employed": true
}, 
    {
    "first_name": "Nilu",
    "last_name": "Peiris",
    "address": null,
    "employed": true
}
];

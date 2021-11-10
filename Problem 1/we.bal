import ballerina/io;

public function main() returns error? {
    map<json>[] newArr = [];

    foreach json val in arr {
        // The `value:ensureType` langlib function can be used to ensure 
        // that the member in the array is a JSON object.
        // The `value:ensureType` function accepts an argument to indicate
        // the type against which the assertion needs to happen.
        // If the argument is not provided, it is inferred from the 
        // contextually-expected type; `map<json>` here.
        // If `val` does not belong to `map<json>`, `value:ensureType` will
        // return an error.
        map<json> person = check val.ensureType();

        // If we have control over the array and can guarantee
        // the contents (i.e., a member is always a JSON object), alternatively
        // we can safely cast `val` to `map<json>`.
        // The difference between casting and using `value:ensureType` is that
        // the former will panic if `val` does not belong to `map<json>` whereas
        // the latter will return an error.
        // map<json> person = <map<json>> val;

        // When lax field access is used with `check`, and the contextually-expected
        // type is a simple basic type or `string`, it is equivalent to using 
        // `value:ensureType`.
        // The following is equivalent to 
        // `boolean employed = check person.employed.ensureType();`.
        boolean employed = check person.employed;

        if !employed {
            continue;
        }

        string name = check person.first_name;

        if person.hasKey("last_name") {
            // Since the `last_name` field may or may not 
            // be present, we check if it is present first.
            string lastName = check person.last_name;
            name += " " + lastName;
        }

        // Create the new JSON object.
        map<json> newPerson = {
            name // same as saying `name: name`
        };

        // Since the `address` field is always present and is
        // either a JSON object or null, we use `map<json>?` as the 
        // contextually-expected type.
        // While `map<json>` allows for JSON object, `nil`
        // allows for null.
        map<json>? address = check person.address.ensureType();

        if address is () {
            // If the address is nil (i.e., null in the original JSON object), 
            // no additional fields have to be added to the `newPerson` JSON object.
            // We can add `newPerson` to `newArr` and continue.
            newArr.push(newPerson);
            continue;
        }

        // This cast is safe since we have already handled the nil case
        // and continued.
        map<json> addressObject = <map<json>>address;

        // If the address is present, set the city and the country.
        string? city = check addressObject.city;
        string? country = check addressObject.country;

        if city is string {
            newPerson["city"] = city;
        }

        if country is string {
            newPerson["country"] = country;
        }

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
        "number": 123,
        "street": "Perera Mawatha",
        "city": "Colombo",
        "country": "Sri Lanka"
    },
    "employed": false
}, 
    {
    "first_name": "Ayra",
    "address": {
        "number": 11,
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

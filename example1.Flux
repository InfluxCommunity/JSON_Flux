import "array"
import "experimental/json"
import "experimental/array"

JSON = bytes(v: "{\"a\": 1, 
 \"b\": 2, 
 \"c\": 3,
 \"timestamp_1\": 1596632400000000000}")


jsonData = json.parse(data: JSON)

// uncomment to display the JSON
// array.from(rows: [{data: display(v: jsonData)}])

// convert the timestamp to a time type with the time() function
// use the array.from() function to create a table 
array.from(rows: [{_time: time(v: int(v: jsonData.timestamp_1)) , a: jsonData.a, b: jsonData.b, c: jsonData.c }])
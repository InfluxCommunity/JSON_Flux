import "array"
import "experimental/json"
import "experimental/array"

JSON = bytes(v: "{\"a\": 1,
 \"list\": [{\"b\": 1.1, 
            \"time\": 1596632400000000000},
           {\"b\": 1.2, 
            \"time\": 1596632500000000000}
          ]
}
")


jsonData = json.parse(data: JSON)

// uncomment to display the JSON
// array.from(rows: [{data: display(v: jsonData)}])

// extract the list that we want to map across with array.map 
listData = jsonData.list
// gather any top level values that you want to include in your table as constants
a = jsonData.a
// map across each complex type in the array named “list” 
list = array.map(
arr: listData,
fn: (x) => ({
// convert the timestamp to a time type with the time() function
"_time": time(v: int(v:x.time)),
"b": x.b,
"a": a
})
)
// finally convert that flattened list into a table with array.from 
array.from(rows: list)
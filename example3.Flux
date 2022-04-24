import "array"
import "experimental/json"
import "experimental/array"

JSON = bytes(v: "{\"a\": 1,
 \"list\": [{\"b\": 1.1, 
            \"nestedList\": [{\"alpha\": \"foo1\", \"beta\": \"bar1\"}, {\"alpha\": \"foo2\", \"beta\": \"foo2\"}],
            \"time\": 1596632400000000000},
           {\"b\": 1.2, 
 	\"nestedList\": [{\"alpha\": \"foo1\", \"beta\": \"bar1\"}, {\"alpha\": \"foo2\", \"beta\": \"foo2\"}],
            \"time\": 1596632500000000000}
          ]
}" )


jsonData = json.parse(data: JSON)

// uncomment to display the JSON
// array.from(rows: [{data: display(v: jsonData)}])

// extract the list that we want to map across with array.map 
listData = jsonData.list
// map across each complex type in the array named “list” 
list = listData |> array.map(fn:(x) => {
             pendingList = x.nestedList
                 |> array.filter(fn: (x) => x.alpha == "foo1")
             pendingAlpha = if length(arr: pendingList) == 1
                 then
                     pendingList[0].alpha
                 else
                     "foo1"
             return {
                 id: x.b,
                 _time: time(v: int(v: x.time)),
                 alpha: pendingAlpha,
             }
         })
array.from(rows: list)


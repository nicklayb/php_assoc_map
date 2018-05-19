# PhpAssocMap

Library that parses PHP's associative array into Elixir's map.

### Current state

At his current state, the library can parse to a 1 level deep array like :
```
[
  'lvl_1_1' => [
    'lvl_2_1' => 1,
    'lvl_2_2' => 'Single quoted string',
    'lvl_2_3' => "Double quoted string"
  ],
  'lvl_1_2' => false
]
```

Which parses to :
```
%{
  "lvl_1_1": %{
    "lvl_2_1": 1,
    "lvl_2_2": "Single quoted string",
    "lvl_2_3": "Double quoted string"
  },
  "lvl_1_2": false
}
```

Parsing 2+ level deep is in the todo

- [ ] Parse 2+ level deep

### Limitations

Currently, the library on supports named keys, which means that straight are not parsed a the moment. This is in the todo list

- [ ] Parse indexed array also


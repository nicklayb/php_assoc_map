# PhpAssocMap

Library that parses PHP's associative array into Elixir's map.

At his current state,

## Installation

Add the following to your `mix.exs` file:
```elixir
defp deps do
  [
    # ...
    {:php_assoc_map, "~> 0.2"}
  ]
end
```

Don't forget to run `mix deps.get` to update dependencies

## Usage

### To map

If you would like to retrieve a map of you array, the function `to_map/1` will do the job.
```elixir
source = """
[
  'lvl_1_1' => [
    'lvl_2_1' => 1,
    'lvl_2_2' => 'Single quoted string',
    'lvl_2_3' => "Double quoted string"
  ],
  'lvl_1_2' => false
]
"""

PhpAssocMap.to_map source

# Outputs
%{
  "lvl_1_1": %{
    "lvl_2_1": 1,
    "lvl_2_2": "Single quoted string",
    "lvl_2_3": "Double quoted string"
  },
  "lvl_1_2": false
}

```

### To tuples

If you would like to retrieve a list o tuples instead of mapof you array, the function `to_tuple/1` will be your friend.
```elixir
source = """
[
  'lvl_1_1' => [
    'lvl_2_1' => 1,
    'lvl_2_2' => 'Single quoted string',
    'lvl_2_3' => "Double quoted string"
  ],
  'lvl_1_2' => false
]
"""

PhpAssocMap.to_tuple source

# Outputs
[
  { :lvl_1_1, [
      {:lvl_2_1, 1},
      {:lvl_2_2, "Single quoted string"},
      {:lvl_2_3, "Double quoted string"}
    ]
  },
  {:lvl_1_2, false}
}

```

### Utilities

#### Clean up

The library includes `PhpAssocMap.Utils.clean_up/1` which cleans up php bloat from the associative array. It remove the
```php
<?php

return
```

before the array return along with the endig semi-colon

## Limitations

### One level deep
the library can parse to a 1 level deep array like :
```php
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
```elixir
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

### Keyed array

Currently, the library on supports named keys, which means that straight are not parsed a the moment. This is in the todo list

- [ ] Parse indexed array also


# PhpAssocMap

[![Build Status](https://travis-ci.org/nicklayb/php_assoc_map.svg?branch=master)](https://travis-ci.org/nicklayb/php_assoc_map)
[![Coverage Status](https://coveralls.io/repos/github/nicklayb/php_assoc_map/badge.svg?branch=master)](https://coveralls.io/github/nicklayb/php_assoc_map?branch=0.4.0)

Library that parses PHP's associative array into Elixir's map.

At his current state,

## Installation

Add the following to your `mix.exs` file:
```elixir
defp deps do
  [
    # ...
    {:php_assoc_map, "~> 0.4"}
  ]
end
```

Don't forget to run `mix deps.get` to update dependencies

## Usage

### Parsing

#### To map

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

#### To tuple

If you would like to retrieve a list o tuple instead of mapof you array, the function `to_tuple/1` will be your friend.
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

### Serializing

#### From map

If you would like to get a serialized version of a map, the function `from_map/1` will do it.
```elixir
source = %{
  "lvl_1_1": %{
    "lvl_2_1": 1,
    "lvl_2_2": "Single quoted string",
    "lvl_2_3": "Double quoted string"
  },
  "lvl_1_2": false
}

PhpAssocMap.from_map source

# Outputs

"""
["lvl_1_1"=>["lvl_2_1"=>1,"lvl_2_2"=>"Single quoted string","lvl_2_3"=>"Double quoted string"],"lvl_1_2"=>false]
"""

```

#### From tuple

If you would like to retrieve a list o tuple instead of mapof you array, the function `to_tuple/1` will be your friend.
```elixir
source = [
  { :lvl_1_1, [
      {:lvl_2_1, 1},
      {:lvl_2_2, "Single quoted string"},
      {:lvl_2_3, "Double quoted string"}
    ]
  },
  {:lvl_1_2, false}
}

PhpAssocMap.from_tuple source

# Outputs

"""
["lvl_1_1"=>["lvl_2_1"=>1,"lvl_2_2"=>"Single quoted string","lvl_2_3"=>"Double quoted string"],"lvl_1_2"=>false]
"""

```

#### Exploding the result

If you would like to print the serialized array to a PHP file, you might want to have indented. For this purpose, you can use the `explode/2` function from the `PhpAssocMap.Utils` module.

```elixir
source = """
["lvl_1_1"=>["lvl_2_1"=>1,"lvl_2_2"=>"Single quoted string","lvl_2_3"=>"Double quoted string"],"lvl_1_2"=>false]
"""
# You can replace de 2 below for the number of space to use
PhpAssocMap.Utils.explode(source, {:spaces, 2})

"""
[
\s\s'lvl_1_1' => [
\s\s\s\s'lvl_2_1' => 1,
\s\s\s\s'lvl_2_2' => 'Single quoted string',
\s\s\s\s'lvl_2_3' => "Double quoted string"
\s\s\s\s],
\s\s'lvl_1_2' => false
\s\s]
"""
```

*You can replace de 2 below for the number of space to use*

##### Or with tabs instead

```elixir
PhpAssocMap.Utils.explode(source, {:tabs})

"""
[
\t'lvl_1_1' => [
\t\t'lvl_2_1' => 1,
\t\t'lvl_2_2' => 'Single quoted string',
\t\t'lvl_2_3' => "Double quoted string"
\t\t],
\t'lvl_1_2' => false
\t]
"""
```

*The function `explode/1` calls back `explode/2` with `{:spaces, 2}` as second parameter*

### Utilities

#### Clean up

The library includes `PhpAssocMap.Utils.clean_up/1` which cleans up php bloat from the associative array. It remove the
```php
<?php

return
```

before the array return along with the endig semi-colon

## Limitations

### Keyed array

Currently, the library on supports named keys, which means that straight are not parsed a the moment. This is in the todo list

### To do
- [x] Parse 2+ level deep (*Special thanks to @richthedev*)
- [ ] Parse indexed array also


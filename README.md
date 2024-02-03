# PhpAssocMap

[![Build Status](https://travis-ci.org/nicklayb/php_assoc_map.svg?branch=master)](https://travis-ci.org/nicklayb/php_assoc_map)
[![Coverage Status](https://coveralls.io/repos/github/nicklayb/php_assoc_map/badge.svg?branch=master)](https://coveralls.io/github/nicklayb/php_assoc_map?branch=master)

Library that parses PHP's associative array into Elixir's map.

At his current state,


## NEW

A rewrite has been done to the parsing to accelerate the process and make more stable. The use of Leex and Yecc had become very handy. Some utils have been removed, if you were using them, we recommend not migrating to 1.0 yet. If you were using `PhpAssocMap.to_tuple/1` or `PhpAssocMap.to_map/1`, everthing should work as it was.

Feel free to post any issue.

## Installation

Add the following to your `mix.exs` file:
```elixir
defp deps do
  [
    # ...
    {:php_assoc_map, "~> 3.0"}
  ]
end
```

Don't forget to run `mix deps.get` to update dependencies

### Note

This library only parses single quoted string as key and value. In PHP, the double quoted string can do interpolation which makes them a bit greedy on performance. For this particular reason, the serialized array will be using single quote. But you can fill any format of associative array (using either single (') or double (") quote as string delimiter)

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
    'lvl_2_3' => 'A string, with "commas" and stuff'
  ],
  'lvl_1_2' => false
]
"""

PhpAssocMap.to_map(source)

# Outputs
%{
  "lvl_1_1": %{
    "lvl_2_1": 1,
    "lvl_2_2": "Single quoted string",
    "lvl_2_3": "A string, with "commas" and stuff"
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
    'lvl_2_3' => "A string, with "commas" and stuff"
  ],
  'lvl_1_2' => false
]
"""

PhpAssocMap.to_tuple(source)

# Outputs
[
  {"lvl_1_1", [
      {"lvl_2_1", 1},
      {"lvl_2_2", "Single quoted string"},
      {"lvl_2_3", "A string, with \"commas\" and stuff"}
    ]
  },
  {"lvl_1_2", false}
}
```

### Serializing

#### From map

If you would like to get a serialized version of a map, the function `from_map/1` will do it.

```elixir
source = %{
  "lvl_1_1" => %{
    "lvl_2_1" => 1,
    "lvl_2_2" => "Single quoted string",
    "lvl_2_3" => "A string, with \"commas\" and stuff"
  },
  "lvl_1_2" => false
}

PhpAssocMap.from_map(source)
```

#### From tuple

If you would like to retrieve a list o tuple instead of mapof you array, the function `to_tuple/1` will be your friend.

```elixir
source = [
  {"lvl_1_1", [
      {"lvl_2_1", 1},
      {"lvl_2_2", "Single quoted string"},
      {"lvl_2_3", "A string, with \"commas\" and stuff"}
    ]
  },
  {"lvl_1_2", false}
}

PhpAssocMap.from_tuple(source)

```

# Outputs

#### Formatting the result

If you would like to print the serialized array to a PHP file, you might want to have indented. For this purpose, you can use the `explode/2` function from the `PhpAssocMap.Utils` module.

```elixir
string_source = """
['lvl_1_1'=>['lvl_2_1'=>1,'lvl_2_2'=>'Single quoted string','lvl_2_3'=>'A string, with "commas" and stuff'],'lvl_1_2'=>false]
"""
source = PhpAssocMap.to_tuple(string_source)
# You can replace de 2 below for the number of space to use
PhpAssocMap.from_tuple(source, {:spaces, 2})

"""
[
\s\s'lvl_1_1' => [
\s\s\s\s'lvl_2_1' => 1,
\s\s\s\s'lvl_2_2' => 'Single quoted string',
\s\s\s\s'lvl_2_3' => 'A string, with "commas" and stuff'
\s\s\s\s],
\s\s'lvl_1_2' => false
\s\s]
"""
```

*You can replace de 2 below for the number of space to use*

##### Or with tabs instead

```elixir
PhpAssocMap.from_tuple(source, :tabs)

"""
[
\t'lvl_1_1' => [
\t\t'lvl_2_1' => 1,
\t\t'lvl_2_2' => 'Single quoted string',
\t\t'lvl_2_3' => 'A string, with "commas" and stuff'
\t\t],
\t'lvl_1_2' => false
\t]
"""
```

##### Or no indentation/breakline

```elixir
PhpAssocMap.from_tuple(source, :none)

"""
[
\t'lvl_1_1' => [
\t\t'lvl_2_1' => 1,
\t\t'lvl_2_2' => 'Single quoted string',
\t\t'lvl_2_3' => 'A string, with "commas" and stuff'
\t\t],
\t'lvl_1_2' => false
\t]
"""
```

## Limitations

### Keyed array

Currently, the library only supports named keys, which means that straight are not parsed a the moment.


Nonterminals
array item association associations.

Terminals
int string float bool open_array close_array comma arrow.

Rootsymbol item.

item -> array : '$1'.
item -> int : unwrap('$1').
item -> string : unquote('$1').
item -> float : unwrap('$1').
item -> bool : unwrap('$1').

array -> open_array associations close_array : '$2'.
array -> open_array close_array : [].

associations -> association comma associations : ['$1' | '$3'].
associations -> association : ['$1'].

association -> item arrow item : {'$1', '$3'}.

Erlang code.
unwrap({_, _, V}) -> V.
unquote(V) -> re:replace(unwrap(V), "\\\\", "", [{return,binary}]).

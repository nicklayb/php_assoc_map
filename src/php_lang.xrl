Definitions.

Whitespace = [\s\t]
Terminator = \n|\r\n|\r
Comma = ,

Digit = [0-9]
NonZeroDigit = [1-9]
NegativeSign = [\-]
Sign = [\+\-]
FractionalPart = \.{Digit}+
True = true
False = false
OpenBracket = \[
CloseBracket = \]
Arrow = \=>
String = "([^"\\]*(\\.[^"\\]*)*)"
Charlist = '([^'\\]*(\\.[^'\\]*)*)'
Return = return
Comment = (/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/)|(//.*)
PhpTag = \<\?php
SemiColon = ;
OpenTextArray = array\(
CloseTextArray = \)

OpenArray   = {OpenBracket}|{OpenTextArray}
CloseArray  = {CloseBracket}|{CloseTextArray}
IntegerPart = {NegativeSign}?0|{NegativeSign}?{NonZeroDigit}{Digit}*
IntValue    = {IntegerPart}
FloatValue  = {IntegerPart}{FractionalPart}|{IntegerPart}{ExponentPart}|{IntegerPart}{FractionalPart}{ExponentPart}

Rules.

{Whitespace}  : skip_token.
{Terminator}  : skip_token.
{Return}      : skip_token.
{Comment}     : skip_token.
{PhpTag}      : skip_token.
{SemiColon}   : skip_token.
{Comma}       : {token, {comma,         TokenLine, list_to_atom(TokenChars)}}.
{IntValue}    : {token, {int,           TokenLine, list_to_integer(TokenChars)}}.
{FloatValue}  : {token, {float,         TokenLine, list_to_float(TokenChars)}}.
{String}      : {token, {string,        TokenLine, string:trim(TokenChars, both, "\"")}}.
{Charlist}    : {token, {string,        TokenLine, string:trim(TokenChars, both, "\'")}}.
{True}        : {token, {bool,          TokenLine, true}}.
{False}       : {token, {bool,          TokenLine, false}}.
{OpenArray}   : {token, {open_array,    TokenLine, list_to_atom(TokenChars)}}.
{CloseArray}  : {token, {close_array,   TokenLine, list_to_atom(TokenChars)}}.
{Arrow}       : {token, {arrow,         TokenLine, list_to_atom(TokenChars)}}.

Erlang code.

%% @author Richard Stewing <richy.sting@gmail.com>
%% @doc Example module to use with edoc 
%% @copyright 2017 Richard Stewing 

-module(example).
-export([example/1]).


%% @doc Adds one to a number.
%% @spec example(integer()) -> integer()
example(0) ->
    1;
example(N) ->
    N+1.

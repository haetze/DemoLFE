-module(module1).
-export([reverse/1]).
-include_lib("eunit/include/eunit.hrl").

reverse([]) ->
    [];
reverse([H|T]) ->
    reverse(T) ++ [H].

reverse_empty_test() ->
    ?assertEqual(reverse([]), []).

reverse_simple_test() ->
    ?assertEqual(reverse([1,2,3,4]), [4,3,2,1]).

reverse_bijectiv_test() ->
    ?assertEqual(reverse(reverse([1,2,3,4,5])), [1,2,3,4,5]).

-module(fiber).
-export([create/1]).

create(F) when is_function(F) ->
    fiber:create(erlang, apply, [F,[]]);
create({M,F}=MF) when is_atom(M), is_atom(F) ->
    fiber:create(erlang, apply, [MF, []]);
create(F) ->
    erlang:error(badarg, [F]).

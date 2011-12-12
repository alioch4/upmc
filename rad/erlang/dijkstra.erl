-module(dijkstra).
-export([init/1]).

init( N ) when N > 1 ->
  Top = spawn( fun() -> wait() end),
  Top ! { init( N - 1, Top, N), random:uniform( N ) , N }.

init( N, Last, Size ) when N > 0 ->
  spawn( fun() -> bottom( init( N-1, Last, Size), random:uniform( N ) ) end);

init( N, List, _Size ) when N =:= 0 ->
  Last.

wait() ->
  receive { Child, State, Size } ->
      top( Child, State, Size )
  end.

top( Child, State, Size ) ->
  io:format("> Top: ~w, Seq#: ~w, State#: ~w ~n", [self(), Child, State]),
  receive
    N when N =:= State ->
      Child ! ((N+1) rem size),
      top( Child, ((N+1) rem Size, Size));
    N when N =/= State ->
      Child ! State,
      top( Child, State, Size)
  after 2000 ->
      Child ! State
      top( Child, State, Size )
  end.

bottom( Child, State ) ->
  io:format("> Bottom: ~w, Seq#: ~w, State#: ~w ~n", [self(), Child, State]),
  receive
    N when N =/= State ->
      Child ! N,
      bottom( Child, N);
    N when N =:= State ->
      Child ! State,
      bottom( Child, State)
  end.


-module(abrectest).
-export([dv/2,dv_proc/0]).

dv(A,B) ->
    PID = spawn(?MODULE,dv_proc,[]),
    PID ! {self(), {A,B}},
    receive Msg ->
	    Msg;
    after 5000 ->
	    failed
    end.

dv_proc() ->
    receive
	{From, {A,B}} when (A == 0) and (B > 4) ->
	    From ! B;
	{From, {A,B}} ->
	    From ! B / A
    end.

-module(dna).

-export([hamming_distance/2]).

hamming_distance(From, To) ->
    % Make both lists the same length, as zipwith expects them to be.
    ToPrime = lists:sublist(To, length(From)),
    FromPrime = lists:sublist(From, length(To)),
    Comparisons = lists:zipwith(fun(X,Y) -> case X =:= Y of
                                          true -> 0;
                                          false -> 1
                                      end
                          end,
                          FromPrime, ToPrime),
    lists:sum(Comparisons).

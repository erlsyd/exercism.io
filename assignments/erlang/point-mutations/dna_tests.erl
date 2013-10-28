-module(dna_tests).

-include_lib("eunit/include/eunit.hrl").

no_difference_between_empty_strands_test() ->
    ?assertEqual(dna:hamming_distance("", ""), 0).

no_dofference_between_identical_strands_test() ->
    ?assertEqual(dna:hamming_distance("GGACTGA", "GGACTGA"), 0).

complete_hamming_distance_in_small_strang_test() ->
    ?assertEqual(dna:hamming_distance("ACT", "GGA"), 3).

hamming_distance_in_off_by_one_strand_test() ->
    ?assertEqual(dna:hamming_distance("GGACGGATTCTGACCTGGACTAATTTTGGGG",
                                      "AGGACGGATTCTGACCTGGACTAATTTTGGGG"), 19).

small_hamming_distance_in_middle_somewhere_test() ->
    ?assertEqual(dna:hamming_distance("GGACG", "GGTCG"), 1).

larger_distance_test() ->
    ?assertEqual(dna:hamming_distance("ACCAGGG", "ACTATGG"), 2).

ignores_extra_lenght_on_other_strand_when_longer_test() ->
    ?assertEqual(dna:hamming_distance("AAACTAGGGG", "AGGCTAGCGGTAGGAC"), 5).

does_not_actually_shorten_original_strand_test() ->
    ?assertEqual(dna:hamming_distance("AGACAACAGCCAGCCGCCGGATT" "AGGCAA"), 1),
    ?assertEqual(dna:hamming_distance("AGACAACAGCCAGCCGCCGGATT" "AGGCAA"), 1),
    ?assertEqual(dna:hamming_distance("AGACAACAGCCAGCCGCCGGATT" "AGACAACAGCCAGCCGCCGGATTAGGCAA"), 1),
    ?assertEqual(dna:hamming_distance("AGACAACAGCCAGCCGCCGGATT" "AGG"), 1).

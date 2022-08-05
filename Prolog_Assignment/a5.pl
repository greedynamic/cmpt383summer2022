% Question 1: fill
% fill(N, X, [X]) :- N = 0.
% fill(N, X, [X|Xs]) :-
%   fill(L, X, Xs),
%   L is N-1.

%
% Question 1: fill
%

fill(1, X, [X]).
fill(N, X, [X|Xs]) :-
    L is N-1,
    L >= 0,
    fill(L, X, Xs).

%
% Question 2: numlist
%

numlist2(H, H, [H]).
numlist2(L, H, [L|Ls]) :-
    Lo is L+1,
    Lo =< H,
    numlist2(Lo, H, Ls).

%
% Question 3: min and max
%

% my_min([X|Xs], Min) :-
%     X =< Min,
%     Min is X,
%     my_min(Xs, Min).

% my_max([X|Xs], Max) :-
%     X >= Max,
%     Max is X,
%     my_max(Xs, Max).

my_min(Y, Z, Y) :- Y =< Z.
my_min(Y, Z, Z) :- Y > Z.

my_max(Y, Z, Y) :- Y >= Z.
my_max(Y, Z, Z) :- Y < Z.

minmax([X], X, X).
minmax([X|Xs], Min, Max) :-
    minmax(Xs, Y, Z),
    my_min(X, Y, Min),
    my_max(X, Z, Max).

%
% Question 4: negpos
%
% negpos([X|Xs], [Y|Ys], [Z|Zs]) :-
%     msort([X|Xs], [Y|Ys]),
%     msort([X|Xs], [Z|Zs]).

% my_neg(Y, [Y]) :- Y < 0.
% my_neg(Y, []) :- Y >= 0.

% my_pos(Y, [Y]) :- Y >= 0.
% my_pos(Y, []) :- Y < 0.

% get_negs([X|Xs], [N|Ns]) :- X >= 0, N < 0.
% get_negs([X|Xs], [N|Ns]) :-
%     my_neg(X, Neg),
%     append(Ns, Neg, NewN),
%     get_negs(Xs, NewN).

% get_negs([X|Xs], [X|Ns]) :-
%     X < 0,
%     get_negs(Xs, Ns).

% get_poss([X|Xs], [P|Ps]) :-
%     get_poss(Xs, Ps),
%     my_pos(X, Ps).

get_negs([], []).
get_negs([X|Xs], [X|Ns]) :-
    X < 0,
    get_negs(Xs, Ns),
    !.
get_negs([_|Xs], Ns) :-
    get_negs(Xs, Ns).

get_non_negs([], []).
get_non_negs([X|Xs], [X|Ns]) :-
    X >= 0,
    get_non_negs(Xs, Ns),
    !.
get_non_negs([_|Xs], Ns) :-
    get_non_negs(Xs, Ns).

negpos(Lst, Negs, NonNegs) :-
    msort(Lst, SortedLst),
    get_negs(SortedLst, Negs),
    get_non_negs(SortedLst, NonNegs).

%
% Question 5: cryptarithmetic
%
alpha([T, I, M, B, Y, U], Tim, Bit, Yumyum) :-
    between(1, 9, T),
    between(0, 9, I), T \= I,
    between(0, 9, M), \+ member(M, [T, I]),
    between(1, 9, B), \+ member(B, [T, I, M]),
    between(1, 9, Y), \+ member(Y, [T, I, M, B]),
    between(0, 9, U), \+ member(U, [T, I, M, B, Y]),
    Tim is T*100 + I*10 + M,
    Bit is B*100 + I*10 + T,
    Yumyum is Y*100100 + U*10010 + M*1001,
    Yumyum is Tim * Bit.

%
% Question 6: magic saquare
%
magic_sol(Nums, A, B, C, D, E, F, G, H, I) :-
    permutation(Nums, [A, B, C, D, E, F, G, H, I]),
    FirstRow is A + B + C,
    SecondRow is D + E + F,
    FirstRow = SecondRow,
    ThirdRow is G + H + I,
    SecondRow = ThirdRow,
    FirstCol is A + D + G,
    ThirdRow = FirstCol,
    SecondCol is B + E + H,
    FirstCol = SecondCol,
    ThirdCol is C + F + I,
    SecondCol = ThirdCol.

magic(L9, Result, N) :-
    magic_sol(L9, A, B, C, D, E, F, G, H, I),
    append([A, B, C, D, E, F, G, H], [I], Result),
    N is A + D + G.

% esempio Prof. Torasso
%
%   stato iniziale      stato finale
%
%                       
%                       a
%                       b
%                       c
%   a                   d
%   b c d e f g h       e

block(a).
block(b).
block(c).
block(d).
block(e).
block(f).
block(g).
block(h).


iniziale(S) :-
    list_to_ord_set(
                    [ clear(a),
                      clear(c),
                      clear(d),
                      clear(e),
                      clear(f),
                      clear(g),
                      clear(h),
                      on(a, b),
                      ontable(b),
                      ontable(c),
                      ontable(d),
                      ontable(e),
                      ontable(f),
                      ontable(g),
                      ontable(h),
                      handempty
                    ],
                    S).

costo(_, 1).

goal(G) :-
    list_to_ord_set([on(a, b), on(b, c), on(c, d), on(d, e), ontable(e)], G).

finale(S) :-
    goal(G),
    ord_subset(G, S).


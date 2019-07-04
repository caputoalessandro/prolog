% stato iniziale    stato finale
%                   a
% a                 b
% b d               c
% c e               d e

block(a).
block(b).
block(c).
block(d).
block(e).

iniziale(S) :-
    list_to_ord_set(
                    [ on(a, b),
                      on(b, c),
                      ontable(c),
                      clear(a),
                      on(d, e),
                      ontable(e),
                      clear(d),
                      handempty
                    ],
                    S).

costo(_, 1).

goal(G) :-
    list_to_ord_set([on(a, b), on(b, c), on(c, d), ontable(d), ontable(e)], G).

finale(S) :-
    goal(G),
    ord_subset(G, S).


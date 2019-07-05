%   stato iniziale      stato finale
%
%   a   d               b   e
%   b   e               c   f   
%   c   f               a   d
   
block(a).
block(b).
block(c).
block(d).
block(e).
block(f).

iniziale(S) :-
    list_to_ord_set(
                    [ clear(d),
                      clear(a),
                      on(d, e),
                      on(e, f),
                      on(b, c),
                      on(a, b),
                      ontable(f),
                      ontable(c),
                      handempty
                    ],
                    S).

%costo(stack(_,_),3).
%costo(unstack(_,_),3).
%costo(pickup(_),1).
%costo(putdown(_),1).

costo(_,1).


goal(G) :-
    list_to_ord_set([ontable(a), ontable(d), on(b,c), on(c,a), on(e,f), on(f,d)], G).

finale(S) :-
    goal(G),
    ord_subset(G, S).

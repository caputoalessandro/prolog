block(a).
block(b).
block(c).

iniziale(S):-
    list_to_ord_set([ontable(a), ontable(b), on(c,b), clear(a),clear(c),handempty], S).
    % crea  un insieme togliendo i doppioni

goal(G):- list_to_ord_set([on(c,a),ontable(a),ontable(b),clear(b), handempty],G).

costo(_, 1).

finale(S):- goal(G), ord_subset(G,S).
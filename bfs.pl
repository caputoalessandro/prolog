:- ["azioni.pl"].

bfs(Soluzione) :-
    iniziale(S),
    bfs_aux([nodo(S, [])], [], Soluzione).


% bfs_aux(Coda,Visitati,Soluzione)
% Coda = [nodo(S,Azioni)|...]
bfs_aux([nodo(S, Azioni)|_], _, Azioni) :-
    finale(S),
    !.

bfs_aux([nodo(S, Azioni)|Tail], Visitati, Soluzione) :-
    findall(Azione, applicabile(Azione, S), ListaApplicabili),
    genera_figli(nodo(S, Azioni),
                ListaApplicabili,
                [S|Visitati],
                ListaFigli),
    append(Tail, ListaFigli, NuovaCoda),
    bfs_aux(NuovaCoda, [S|Visitati], Soluzione).


genera_figli(_, [], _, []).

genera_figli(nodo(S, AzioniPerS), [Azione|AltreAzioni], Visitati, [nodo(SNuovo, [Azione|AzioniPerS])|FigliTail]) :-
    trasforma(Azione, S, SNuovo),
    \+ member(SNuovo, Visitati),
    !,
    genera_figli(nodo(S, AzioniPerS), AltreAzioni, Visitati, FigliTail).

genera_figli(nodo(S, AzioniPerS), [_|AltreAzioni], Visitati, FigliTail) :-
    genera_figli(nodo(S, AzioniPerS), AltreAzioni, Visitati, FigliTail).

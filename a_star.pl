:- ["azioni.pl", "dominio3.pl", "euristica_2.pl"].
:- set_prolog_stack(global, limit(100 000 000 000)).

a_star(Soluzione) :-
    iniziale(S),
    a_star_aux([nodo(0, 0, S, [])], [], Soluzione).

a_star_aux([nodo(_, _, S, Azioni)|_], _, Azioni) :-
    finale(S).

a_star_aux([nodo(CostoPiuEuristica, Costo, S, Azioni)|Tail], Visitati, Soluzione) :-
    findall(Applicabile, applicabile(Applicabile, S), ListaApplicabili),
    genera_figli(nodo(CostoPiuEuristica, Costo, S, Azioni),
                 ListaApplicabili,
                 [S|Visitati],
                 ListaFigli),
    append(Tail, ListaFigli, NuovaCoda),
    list_to_ord_set(NuovaCoda, ListaOrdinata),
    a_star_aux(ListaOrdinata, [S|Visitati], Soluzione).

% genera_figli(+NodoPartenza, +AzioniApplicabili, +Visitati, -NuoviFigli)
genera_figli(_, [], _, []).

genera_figli(Nodo, [Applicabile|AltriApplicabili], Visitati, [Figlio|FigliTail]) :-
    Nodo=nodo(_, Costo, S, AzioniPerS),
    trasforma(Applicabile, S, SNuovo),  
    \+ member(SNuovo, Visitati),
    !,
    euristica(SNuovo, Euristica),
    costo(Applicabile, CostoApplicabile),
    CostoFiglio is CostoApplicabile+Costo,
    CostoPiuEuristicaFiglio is CostoFiglio+Euristica,
    Figlio=nodo(CostoPiuEuristicaFiglio, CostoFiglio, SNuovo, [Applicabile|AzioniPerS]),
    genera_figli(Nodo, AltriApplicabili, Visitati, FigliTail).

genera_figli(nodo(CostoPiuEuristica, Costo, S, AzioniPerS), [_|AltriApplicabili], Visitati, FigliTail) :-
    genera_figli(nodo(CostoPiuEuristica, Costo, S, AzioniPerS),
                 AltriApplicabili,
                 Visitati,
                 FigliTail).



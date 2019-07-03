:- use_module(library(apply)).

is_on(on(_,_)).
is_ontable(ontable(_)).

euristica(StatoAttuale, Valore) :-
    goal(StatoFinale),
    ord_subtract(StatoFinale, StatoAttuale, DifferenzaStati),
    include(is_on, DifferenzaStati, StatiOn),
    include(is_ontable, DifferenzaStati, StatiOntable),
    length(StatiOn, LunghezzaStatiOn),
    length(StatiOntable, LunghezzaStatiOntable),
    ValoreOn is LunghezzaStatiOn * 2,
    ValoreTable is LunghezzaStatiOntable,
    Valore is max(1,ValoreOn + ValoreTable).

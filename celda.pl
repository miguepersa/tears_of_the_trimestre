
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% predicado auxiliar

concat([], Cs, Cs).

concat([A|As], Bs,[A|Cs]):-
          concat(As, Bs, Cs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Pasillos seguros

cruzar(Mapa, Palancas, Seguro) :- 
    Mapa = pasillo(X, Modo),
    Modo = regular,
    member((X, arriba), Palancas),
    Seguro = seguro.

cruzar(Mapa, Palancas, Seguro) :- 
    Mapa = pasillo(X, Modo),
    Modo = de_cabeza,
    member((X, abajo), Palancas),
    Seguro = seguro.

%% Pasillos trampas

cruzar(Mapa, Palancas, Seguro) :- 
    Mapa = pasillo(X, Modo),
    Modo = regular,
    member((X, abajo), Palancas),
    Seguro = trampa.

cruzar(Mapa, Palancas, Seguro) :- 
    Mapa = pasillo(X, Modo),
    Modo = de_cabeza,
    member((X, arriba), Palancas),
    Seguro = trampa.


% Juntas
% To do



 
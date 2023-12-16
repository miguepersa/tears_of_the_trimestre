limpiar([], []).
limpiar([Hx|Tx], [Hx|Ty]) :- nonvar(Hx), limpiar(Tx, Ty),!.
limpiar([Hx|_], []) :- var(Hx).

palancas_duplicadas(Palancas) :-
    member((X, arriba), Palancas), 
    member((X, abajo), Palancas), !.

% Definición de la relación cruzar/3
cruzar(Mapa, Palancas, Seguro) :-
    nonvar(Mapa),
    cruzar_aux(Mapa, Palancas_2, Seguro),
    limpiar(Palancas_2, Palancas),
    not(palancas_duplicadas(Palancas)).

% Caso base: cruzar un pasillo regular con la palanca hacia arriba
cruzar_aux(pasillo(X, regular), Palancas, seguro) :-
    member((X, arriba), Palancas), !.

cruzar_aux(pasillo(X, de_cabeza), Palancas, seguro) :-
    member((X, abajo), Palancas), !.

cruzar_aux(pasillo(X, regular), Palancas, trampa) :-
    member((X, abajo), Palancas), !.

cruzar_aux(pasillo(X, de_cabeza), Palancas, trampa) :-
    member((X, arriba), Palancas), !.

% Caso recursivo: cruzar una junta (secuencia de dos submapas)
cruzar_aux(junta(X, Y), Palancas, seguro) :-
    cruzar_aux(X, Palancas, seguro),
    cruzar_aux(Y, Palancas, seguro).

cruzar_aux(junta(X, Y), Palancas, trampa) :-
    cruzar_aux(X, Palancas, trampa),
    cruzar_aux(Y, Palancas, seguro).

cruzar_aux(junta(X, Y), Palancas, trampa) :-
    cruzar_aux(X, Palancas, seguro),
    cruzar_aux(Y, Palancas, trampa).

cruzar_aux(junta(X, Y), Palancas, trampa) :-
    cruzar_aux(X, Palancas, trampa),
    cruzar_aux(Y, Palancas, trampa).

% Caso recursivo: cruzar una bifurcación (al menos uno de los dos submapas debe ser seguro)
cruzar_aux(bifurcacion(X, Y), Palancas, seguro) :-
    cruzar_aux(X, Palancas, seguro),
    cruzar_aux(Y, Palancas, seguro).

cruzar_aux(bifurcacion(X, Y), Palancas, seguro) :-
    cruzar_aux(X, Palancas, trampa),
    cruzar_aux(Y, Palancas, seguro).

cruzar_aux(bifurcacion(X, Y), Palancas, seguro) :-
    cruzar_aux(X, Palancas, seguro),
    cruzar_aux(Y, Palancas, trampa).

cruzar_aux(bifurcacion(X, Y), Palancas, trampa) :-
    cruzar_aux(X, Palancas, trampa),
    cruzar_aux(Y, Palancas, trampa).


% Definición del predicado siempre_seguro/1
siempre_seguro(Mapa) :- \+ (cruzar(Mapa, _, trampa)).

leer(Mapa) :-
	write( user_output, "Ingrese el nombre del archivo: " ), flush_output( user_output ),
	read_string( user_input, "\n", " ", _End, Filename),
    atom_string(AtomFn, Filename),
	seeing(OldStream),
    see(AtomFn),
    read(Mapa),
    seen, see(OldStream).
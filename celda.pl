% Definición de la relación cruzar/3
cruzar(Mapa, Palancas, Seguro) :-
    % Verificar que Mapa esté instanciado y no sea una variable
    nonvar(Mapa),
    % Verificar que Palancas esté instanciado o sea una variable
    cruzar_aux(Mapa, Palancas, Seguro, []).

% Caso base: cruzar un pasillo regular con la palanca hacia arriba
cruzar_aux(pasillo(X, regular), Palancas, seguro, _) :-
    member((X, arriba), Palancas).
cruzar_aux(pasillo(X, regular), Palancas, trampa, _) :-
    member((X, abajo), Palancas).

% Caso base: cruzar un pasillo de cabeza con la palanca hacia abajo
cruzar_aux(pasillo(X, de_cabeza), Palancas, seguro, _) :-
    member((X, abajo), Palancas).
cruzar_aux(pasillo(X, de_cabeza), Palancas, trampa, _) :-
    member((X, arriba), Palancas).

% Caso recursivo: cruzar una junta (secuencia de dos submapas)
cruzar_aux(junta(SubMapa1, SubMapa2), Palancas, Seguro, Visitados) :-
    cruzar_aux(SubMapa1, Palancas, Seguro1, Visitados),
    cruzar_aux(SubMapa2, Palancas, Seguro2, Visitados),
    % Si cruzar ambos submapas es seguro, entonces es seguro
    (Seguro1 = seguro, Seguro2 = seguro -> Seguro = seguro ; Seguro = trampa).

% Caso recursivo: cruzar una bifurcación (cualquiera de los dos submapas es suficiente)
cruzar_aux(bifurcacion(SubMapa1, SubMapa2), Palancas, Seguro, Visitados) :-
    % Intentar cruzar el primer submapa
    cruzar_aux(SubMapa1, Palancas, Seguro1, Visitados),
    % Si cruzar el primer submapa es seguro, entonces es seguro
    (Seguro1 = seguro -> Seguro = seguro
    % Si no, intentar cruzar el segundo submapa
    ; cruzar_aux(SubMapa2, Palancas, Seguro2, Visitados),
      % Si cruzar el segundo submapa es seguro, entonces es seguro
      (Seguro2 = seguro -> Seguro = seguro ; Seguro = trampa)
    ).

% Verificar si existe alguna combinación de palancas que permita cruzar el laberinto
% (usando la técnica de backtracking)
cruzar_aux(_, _, seguro, _).

% Verificar si la combinación actual de palancas lleva a una trampa
cruzar_aux(_, _, trampa, _) :-
    fail.


% Predicado para manejar el caso de bifurcaciones en el laberinto
cruzar_aux(SubMapa, Palancas, Seguro, Visitados, RVisited) :-
    SubMapa \= bifurcacion(_, _),
    \+ member(SubMapa, Visitados),
    % Añadir SubMapa a la lista de visitados para este nivel
    cruzar_aux(SubMapa, Palancas, Seguro, [SubMapa | Visitados], RVisited),
    % Añadir SubMapa a la lista de visitados global
    cruzar_aux(SubMapa, Palancas, Seguro, [SubMapa | RVisited], RVisited).


% Definición del predicado siempre_seguro/1
siempre_seguro(Mapa) :-
    % Verificar que Mapa esté instanciado y no sea una variable
    nonvar(Mapa),
    % Llamar al predicado auxiliar siempre_seguro_aux/2 para realizar la verificación
    siempre_seguro_aux(Mapa, []).

% Caso base: el pasillo regular siempre puede cruzarse
siempre_seguro_aux(pasillo(_, regular), _).

% Caso base: el pasillo de cabeza siempre puede cruzarse
siempre_seguro_aux(pasillo(_, cabeza), _).

% Caso recursivo: siempre es seguro cruzar una junta (secuencia de dos submapas)
siempre_seguro_aux(junta(SubMapa1, SubMapa2), Visitados) :-
    siempre_seguro_aux(SubMapa1, Visitados),
    siempre_seguro_aux(SubMapa2, Visitados).

% Caso recursivo: siempre es seguro cruzar una bifurcación (cualquiera de los dos submapas es suficiente)
siempre_seguro_aux(bifurcacion(SubMapa1, SubMapa2), Visitados) :-
    siempre_seguro_aux(SubMapa1, Visitados),
    siempre_seguro_aux(SubMapa2, Visitados).

% Predicado para manejar el caso de bifurcaciones en el laberinto
siempre_seguro_aux(SubMapa, Visitados) :-
    SubMapa \= bifurcacion(_, _),
    \+ member(SubMapa, Visitados),
    siempre_seguro_aux(SubMapa, [SubMapa | Visitados]).

leer(Mapa) :-
	write( user_output, "Ingrese el nombre del archivo: " ), flush_output( user_output ),
	read_string( user_input, "\n", " ", _End, Filename),
	open(Filename,read,File), 
	read(File,Mapa),
	close(File).
%%%%%%%%%%%%%%%%%%   PROPIEDADES   %%%%%%%%%%%%%%%%%%

precio(tinsmith_Circle_1774,700).
precio(av_Moreno_708,2000).
precio(av_Siempre_Viva_742,1000).
precio(calle_Falsa_123,200).

tiene(tinsmith_Circle_1774,ambientes(3)).
tiene(tinsmith_Circle_1774,jardin).
tiene(av_Moreno_708,ambientes(7)).
tiene(av_Moreno_708,jardin).
tiene(av_Moreno_708,metrosCubicos(30)).
tiene(av_Siempre_Viva_742,ambientes(4)).
tiene(av_Siempre_Viva_742,jardin).
tiene(calle_Falsa_123,ambientes(3)).

%%%%%%%%%%%%%%%%%%   USUARIOS   %%%%%%%%%%%%%%%%%%

quiere(carlos,ambientes(3)).
quiere(carlos, jardin).
quiere(ana,metrosCubicos(100)).
quiere(maria,ambientes(2)).
quiere(maria,metrosCubicos(15)).
quiere(pedro,Caracteristica) :-
  quiere(maria,Caracteristica).

persona(Nombre) :- quiere(Nombre,_).

propiedad(Nombre) :- tiene(Nombre, _).

caracteristica(Caracteristica) :- quiere(_, Caracteristica).

%quiere(chamaleon,Caracteristica) :-
%  Nombre \= chamaleon,
%  persona(Nombre),
%  quiere(Nombre,Caracteristica).

%%%%%%%%%%%%%%%%%%      %%%%%%%%%%%%%%%%%%

cumpleConCaracteristica(Propiedad,Caracteristica) :-
  tiene(Propiedad,Caracteristica).

cumpleConCaracteristica(Propiedad,ambientes(Cantidad)) :-
  quiere(_,ambientes(Cantidad)),
  tiene(Propiedad,ambientes(CantidadDeLaPropiedad)),
  CantidadDeLaPropiedad >= Cantidad.

cumpleConCaracteristica(Propiedad,metrosCubicos(Cantidad)) :-
  quiere(_,metrosCubicos(Cantidad)),
  tiene(Propiedad, metrosCubicos(CantidadDeLaPropiedad)),
  CantidadDeLaPropiedad >= Cantidad.

noCumple(Propiedad, Caracteristica) :-
  caracteristica(Caracteristica),
  not(cumpleConCaracteristica(Propiedad, Caracteristica)).

cumpleTodo(Cliente, Propiedad):-
  propiedad(Propiedad),
  persona(Cliente),
  forall(quiere(Cliente, Caracteristica),cumpleConCaracteristica(Propiedad, Caracteristica)).

%mejorOpcion(Cliente, Propiedad) :-
%  cumpleTodo(Cliente, Propiedad),
%  mejorPrecio(Propiedad).

%mejorPrecio(Propiedad) :-
%  precio(Propiedad, Precio1),
%  precio(OtraPropiedad, Precio2),
%  Propiedad \= OtraPropiedad,
%  Precio1 < Precio2.

mejorOpcion(Cliente, Propiedad) :-
  propiedad(Propiedad),
  cumpleTodo(Cliente, Propiedad),
  forall((precio(OtraPropiedad, OtroPrecio), cumpleTodo(Cliente, OtraPropiedad)), (precio(Propiedad, Precio), Precio =< OtroPrecio)).

satisfecho(Cliente) :-
  persona(Cliente),
  cumpleTodo(Cliente,_).

encontrarSatisfechos(SatisfechosSinRepetir) :-
  findall(ClienteSatisfecho, satisfecho(ClienteSatisfecho), SatisfechosRepetidos),
  list_to_set(SatisfechosRepetidos, SatisfechosSinRepetir).

todosLosClientes(ClientesSinRepetir) :-
  findall(Cliente, persona(Cliente), ClientesRepetidos),
  list_to_set(ClientesRepetidos, ClientesSinRepetir).

efectividad(Nivel) :-
  encontrarSatisfechos(Satisfechos),
  todosLosClientes(Clientes),
  length(Satisfechos, CuantosSatisfechos),
  length(Clientes, CuantosClientes),
  Nivel is CuantosSatisfechos/CuantosClientes.

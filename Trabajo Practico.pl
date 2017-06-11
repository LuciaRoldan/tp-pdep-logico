%%%%%%%%%%%%%%%%%%   PROPIEDADES   %%%%%%%%%%%%%%%%%%

precio(tinsmith_Circle_1774, 700).
precio(av_Moreno_708, 2000).
precio(av_Siempre_Viva_742, 1000).
precio(calle_Falsa_123, 200).

tiene(tinsmith_Circle_1774, ambientes(3)).
tiene(tinsmith_Circle_1774, jardin).
tiene(av_Moreno_708, ambientes(7)).
tiene(av_Moreno_708, jardin).
tiene(av_Moreno_708, piscina(30)).
tiene(av_Siempre_Viva_742, ambientes(4)).
tiene(av_Siempre_Viva_742, jardin).
tiene(calle_Falsa_123, ambientes(3)).
tiene(tinsmith_Circle_1774, instalaciones([aireAcondicionado, extractor, calefaccion(gas)])).
tiene(av_Moreno_708, instalaciones([aireAcondicionado, extractor, calefaccion(lozaRadiante), vidriosDobles])).
tiene(av_Siempre_Viva_742, instalaciones([calefaccion(gas)])).

%%%%%%%%%%%%%%%%%%%   USUARIOS   %%%%%%%%%%%%%%%%%%%%

persona(carlos).
persona(ana).
persona(maria).
persona(pedro).
persona(chamaleon).

quiere(carlos,ambientes(3)).
quiere(carlos, jardin).
quiere(ana,piscina(100)).
quiere(maria,ambientes(2)).
quiere(maria,piscina(15)).
quiere(pedro,Caracteristica) :-
  quiere(maria,Caracteristica).
quiere(ana, instalaciones([aireAcondicionado, vidriosDobles])).
quiere(pedro, instalaciones([vidriosDobles, calefaccion(lozaRadiante)])).

quiere(chamaleon,Caracteristica) :-
  persona(Nombre),
  Nombre \= chamaleon,
  quiere(Nombre,Caracteristica).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

propiedad(Nombre) :- tiene(Nombre, _).
caracteristica(Caracteristica) :- quiere(_, Caracteristica).

cumpleConCaracteristica(Propiedad,Caracteristica) :-
  tiene(Propiedad,Caracteristica).

cumpleConCaracteristica(Propiedad,ambientes(Cantidad)) :-
  caracteristica(ambientes(Cantidad)),
  tiene(Propiedad,ambientes(CantidadDeLaPropiedad)),
  CantidadDeLaPropiedad >= Cantidad.

cumpleConCaracteristica(Propiedad,piscina(Cantidad)) :-
  caracteristica(piscina(Cantidad)),
  tiene(Propiedad, piscina(CantidadDeLaPropiedad)),
  CantidadDeLaPropiedad >= Cantidad.

cumpleConCaracteristica(Propiedad,instalaciones(InstalacionesBuscadas)) :-
  %quiere(_,instalaciones(InstalacionesBuscadas)),
  caracteristica(instalaciones([InstalacionesBuscadas])),
  tiene(Propiedad,instalaciones(InstalacionesDeLaPropiedad)),
  forall(member(Instalacion,InstalacionesBuscadas),member(Instalacion,InstalacionesDeLaPropiedad)).

noCumple(_, Caracteristica) :-
  caracteristica(Caracteristica),
  not(cumpleConCaracteristica(_, Caracteristica)).

cumpleTodo(Cliente, Propiedad):-
  propiedad(Propiedad),
  persona(Cliente),
  forall(quiere(Cliente, Caracteristica),cumpleConCaracteristica(Propiedad, Caracteristica)).

mejorOpcion(Cliente, Propiedad) :-
  propiedad(Propiedad),
  cumpleTodo(Cliente, Propiedad),
  precio(Propiedad, Precio),
  forall(cumpleTodo(Cliente, OtraPropiedad), (precio(OtraPropiedad, OtroPrecio), Precio =< OtroPrecio)).

mejorOpcion2(Cliente, Propiedad) :-
  cumpleTodo(Cliente,Propiedad),
  precio(Propiedad, PrecioDeLaPropiedad),
  not((cumpleTodo(Cliente, OtraPropiedad), precio(OtraPropiedad, OtroPrecio), (OtroPrecio < PrecioDeLaPropiedad))).

satisfecho(Cliente) :-
  cumpleTodo(Cliente,_).

satisfechos(SatisfechosSinRepetir) :-
  findall(ClienteSatisfecho, satisfecho(ClienteSatisfecho), SatisfechosRepetidos),
  list_to_set(SatisfechosRepetidos, SatisfechosSinRepetir).

todosLosClientes(ClientesSinRepetir) :-
  findall(Cliente, persona(Cliente), ClientesRepetidos),
  list_to_set(ClientesRepetidos, ClientesSinRepetir).

efectividad(Nivel) :-
  satisfechos(Satisfechos),
  todosLosClientes(Clientes),
  length(Satisfechos, CuantosSatisfechos),
  length(Clientes, CuantosClientes),
  Nivel is CuantosSatisfechos/CuantosClientes.

esChica(Propiedad) :-
  tiene(Propiedad, ambientes(1)).

esChica(Propiedad) :-
  propiedad(Propiedad),
  not(tiene(Propiedad, ambientes(_))).

propiedadTop(Propiedad) :-
  cumpleConCaracteristica(Propiedad,instalaciones([aireAcondicionado])),
  not(esChica(Propiedad)).

propiedadesTop(PropiedadesTop) :-
  findall(Propiedad, propiedadTop(Propiedad), PropiedadesTopRepetidas),
  list_to_set(PropiedadesTopRepetidas, PropiedadesTop).


%%%%%%%%%%%%%%%%%%%%   BONUS   %%%%%%%%%%%%%%%%%%%%%%

% Lo que se repite es el findall y el list_to_set

encontrarSinRepetidos(ListaSinRepetir, Condicion) :-
  findall(Elemento, call(Condicion, Elemento), ListaRepetida),
  list_to_set(ListaRepetida, ListaSinRepetir).

nuevoSatisfechos(Satisfechos) :-
  encontrarSinRepetidos(Satisfechos, satisfecho).

nuevoTodosLosClientes(Clientes) :-
  encontrarSinRepetidos(Clientes, persona).

nuevoPropiedadesTop(PropiedadesTop) :-
  encontrarSinRepetidos(PropiedadesTop, propiedadTop).

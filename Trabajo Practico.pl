%%%%%%%%%%%%%%%%%%   PROPIEDADES   %%%%%%%%%%%%%%%%%%

precio(tinsmith_Circle_1774, 700).
precio(av_Moreno_708, 2000).
precio(av_Siempre_Viva_742, 1000).
precio(calle_Falsa_123, 200).

tiene(tinsmith_Circle_1774, ambientes(3)).
tiene(tinsmith_Circle_1774, jardin).
tiene(av_Moreno_708, ambientes(7)).
tiene(av_Moreno_708, jardin).
tiene(av_Moreno_708, metrosCubicos(30)).
tiene(av_Siempre_Viva_742, ambientes(4)).
tiene(av_Siempre_Viva_742, jardin).
tiene(calle_Falsa_123, ambientes(3)).
tiene(tinsmith_Circle_1774, instalaciones([aireAcondicionado, extractor, calefaccion(gas)])).
tiene(av_Moreno_708, instalaciones([aireAcondicionado, extractor, calefaccion(lozaRadiante), vidriosDobles])).
tiene(av_Siempre_Viva_742, instalaciones([calefaccion(gas)])).

%%%%%%%%%%%%%%%%%%%   USUARIOS   %%%%%%%%%%%%%%%%%%%%

quiere(carlos,ambientes(3)).
quiere(carlos, jardin).
quiere(ana,metrosCubicos(100)).
quiere(maria,ambientes(2)).
quiere(maria,metrosCubicos(15)).
quiere(pedro,Caracteristica) :-
  quiere(maria,Caracteristica).
quiere(ana, instalaciones([aireAcondicionado, vidriosDobles])).
quiere(pedro, instalaciones([vidriosDobles, calefaccion(lozaRadiante)])).


quiere(chamaleon,Caracteristica) :-
  persona(Nombre),
  Nombre \= chamaleon,
  quiere(Nombre,Caracteristica).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

persona(carlos).
persona(ana).
persona(maria).
persona(pedro).
persona(chamaleon).
propiedad(Nombre) :- tiene(Nombre, _).
caracteristica(Caracteristica) :- quiere(_, Caracteristica).

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

cumpleConCaracteristica(Propiedad,instalaciones(UnasInstalaciones)) :-
  quiere(_,instalaciones(UnasInstalaciones)),
  tiene(Propiedad,instalaciones(OtrasInstalaciones)),
  forall(member(Instalacion,UnasInstalaciones),member(Instalacion,OtrasInstalaciones)).

noCumple(Propiedad, Caracteristica) :-
  caracteristica(Caracteristica),
  not(cumpleConCaracteristica(Propiedad, Caracteristica)).

cumpleTodo(Cliente, Propiedad):-
  propiedad(Propiedad),
  persona(Cliente),
  forall(quiere(Cliente, Caracteristica),cumpleConCaracteristica(Propiedad, Caracteristica)).

mejorOpcion(Cliente, Propiedad) :-
  propiedad(Propiedad),
  cumpleTodo(Cliente, Propiedad),
  forall((precio(OtraPropiedad, OtroPrecio), cumpleTodo(Cliente, OtraPropiedad)), (precio(Propiedad, Precio), Precio =< OtroPrecio)).


mejorOpcion2(Cliente, Propiedad) :-
  quiere(Cliente,_),
  findall(Precio,(precio(Propiedad,Precio),cumpleTodo(Cliente,Propiedad)),Precios),
  min_member(PrecioMinimo,Precios),
  precio(Propiedad,PrecioMinimo).


satisfecho(Cliente) :-
  persona(Cliente),
  cumpleTodo(Cliente,_).

encontrarSatisfechos(SatisfechosSinRepetir) :-
  findall(ClienteSatisfecho, satisfecho(ClienteSatisfecho), SatisfechosRepetidos),
  list_to_set(SatisfechosRepetidos, SatisfechosSinRepetir).

encontrarTodosLosClientes(ClientesSinRepetir) :-
  findall(Cliente, persona(Cliente), ClientesRepetidos),
  list_to_set(ClientesRepetidos, ClientesSinRepetir).

efectividad(Nivel) :-
  encontrarSatisfechos(Satisfechos),
  encontrarTodosLosClientes(Clientes),
  length(Satisfechos, CuantosSatisfechos),
  length(Clientes, CuantosClientes),
  Nivel is CuantosSatisfechos/CuantosClientes.

esChica(Propiedad) :-
  propiedad(Propiedad),
  tiene(Propiedad, ambientes(1)).

esChica(Propiedad) :-
  propiedad(Propiedad),
  not(tiene(Propiedad, ambientes(_))).

tieneAire(Propiedad) :-
  propiedad(Propiedad),
  tiene(Propiedad, instalaciones(Instalaciones)),
  member(aireAcondicionado, Instalaciones).

propiedadTop(Propiedad) :-
  not(esChica(Propiedad)),
  tieneAire(Propiedad).

propiedadesTop(PropiedadesTop) :-
  findall(Propiedad, propiedadTop(Propiedad), PropiedadesTopRepetidas),
  list_to_set(PropiedadesTopRepetidas, PropiedadesTop).


%%%%%%%%%%%%%%%%%%%%   BONUS   %%%%%%%%%%%%%%%%%%%%%%

% Lo que se repite es el findall y el list_to_set

encontrarSinRepetidos(ListaSinRepetir, Condicion) :-
  findall(Elemento, call(Condicion, Elemento), ListaRepetida),
  list_to_set(ListaRepetida, ListaSinRepetir).

nuevoEncontrarSatisfechos(Satisfechos) :-
  encontrarSinRepetidos(Satisfechos, satisfecho).

nuevoEncontrarTodosLosClientes(Clientes) :-
  encontrarSinRepetidos(Clientes, persona).

nuevopropiedadesTop(PropiedadesTop) :-
  encontrarSinRepetidos(PropiedadesTop, propiedadTop).

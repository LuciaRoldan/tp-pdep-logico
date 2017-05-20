%%%%%%%%%%%%%%%%%%   PROPIEDADES   %%%%%%%%%%%%%%%%%%
%(nombre, ambientes, jardín?, metros cubicos de la piscina)
%Los precios no importan? (700/ 2000/ 1000/ 200)

propiedad(tinsmith_Circle_1774, 3, si, 0).
propiedad(av_Moreno_708, 7, si, 30).
propiedad(av_Siempre_Viva_742, 4, si, 0).
propiedad(calle_Falsa_123, 3, no, 0).

%%%%%%%%%%%%%%%%%%   USUARIOS   %%%%%%%%%%%%%%%%%%
usuario(carlos, 3, si, 0).
usuario(ana, 0, no, 100).
usuario(maria, 2, no, 15).
usuario(pedro, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(maria, UnosAmbientes, Unjardin, UnosMetrosCubicos).


<<<<<<< HEAD
%Chameleon2
usuario(chamaleon, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(Nombre, UnosAmbientes, Unjardin, UnosMetrosCubicos),
  Nombre \= chamaleon.

=======
>>>>>>> master

compararAmbiente(Nombre1, UnosAmbientes, UnJardin, UnosMetrosCubicos) :-
  propiedad(Nombre1, UnosAmbientes, UnJardin, UnosMetrosCubicos),
  propiedad(Nombre2, UnosAmbientes, _, _),
  Nombre1 \= Nombre2.


cumpleConCaracteristica(Nombre, AmbientesBuscados, Jardin, MetrosCubicosBuscados) :-
  propiedad(Nombre, AmbientesPosta, Jardin, MetrosCubicosPosta),
  AmbientesPosta >= AmbientesBuscados,
  MetrosCubicosPosta >= MetrosCubicosBuscados.


cumpleConCaracteristica(NombrePropiedad, NombrePersona) :-
  usuario(NombrePersona, AmbientesBuscados, Jardin, MetrosCubicosBuscados),
  propiedad(NombrePropiedad, AmbientesPosta, Jardin, MetrosCubicosPosta),
  AmbientesPosta >= AmbientesBuscados,
  MetrosCubicosPosta >= MetrosCubicosBuscados.

queSeDesea(NombrePropiedad, NombrePersona, Ambientes, _, _):-
  usuario(NombrePersona, Ambientes, _, _),
  propiedad(NombrePropiedad, Ambientesp, _, _),
  Ambientes =< Ambientesp.
queSeDesea(NombrePropiedad, NombrePersona, _, _, MetrosCubicos):-
  usuario(NombrePersona, _, _, MetrosCubicos),
  propiedad(NombrePropiedad, _, _, MetrosCubicosp),
  MetrosCubicos =< MetrosCubicosp.
queSeDesea(NombrePropiedad, NombrePersona, _, Jardin, _):-
  usuario(NombrePersona, _, Jardin, _),
  propiedad(NombrePropiedad, _, Jardin, _).

%cumpleConCaracteristica(Propiedad, Caracteristica) :-
%  Propiedad(_, Ambientes, Jardin, Piscina),
%  Caracteristica(Ambientes, Jardin, Piscina).

%cumpleConCaracteristica(Propiedad, Caracteristica) :-
%  Propiedad(_, Ambientes, Jardin, Piscina),
%  Caracteristica(Ambientes2, Jardin, Piscina2),
%  Ambientes2 >= Ambientes,
%  Piscina2 >= Piscina.

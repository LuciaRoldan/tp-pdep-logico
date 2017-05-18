%%%%%%%%%%%%%%%%%%   PROPIEDADES   %%%%%%%%%%%%%%%%%%
%(nombre, ambientes, jardín?, metros cubicos de la piscina)
%Los precios no importan? (700/ 2000/ 1000/ 200)

propiedad(tinsmith_Circle_1774, 3, si, 0).
propiedad(av_Moreno_708, 7, si, 30).
propiedad(av_Siempre_Viva_742, 4, si, 0).
propiedad(calle_Falsa_123, 3, no, 0).


%%%%%%%%%%%%%%%%%%   USUARIOS   %%%%%%%%%%%%%%%%%%
usuario(carlos, 3, si, 0).
usuario(ana, 0, _, 100).
usuario(maria, 2, _, 15).
usuario(pedro, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(maria, UnosAmbientes, Unjardin, UnosMetrosCubicos).
%Chamaleon:
usuario(chamaleon, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(maria, UnosAmbientes, Unjardin, UnosMetrosCubicos).
usuario(chamaleon, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(carlos, UnosAmbientes, Unjardin, UnosMetrosCubicos).
usuario(chamaleon, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(ana, UnosAmbientes, Unjardin, UnosMetrosCubicos).
usuario(chamaleon, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(pedro, UnosAmbientes, Unjardin, UnosMetrosCubicos).

%Chameleon2
usuario(chamaleon, UnosAmbientes, Unjardin, UnosMetrosCubicos) :-
  usuario(_, UnosAmbientes, Unjardin, UnosMetrosCubicos).


compararAmbiente(Nombre1, UnosAmbientes, UnJardin, UnosMetrosCubicos) :-
  propiedad(Nombre1, UnosAmbientes, UnJardin, UnosMetrosCubicos),
  propiedad(Nombre2, UnosAmbientes, _, _),
  Nombre1 \= Nombre2.


cumpleConCaracteristica(Nombre, AmbientesBuscados, Jardin, MetrosCubicosBuscados) :-
  propiedad(Nombre, AmbientesPosta, Jardin, MetrosCubicosPosta),
  AmbientesPosta >= AmbientesBuscados,
  MetrosCubicosPosta >= MetrosCubicosBuscados.


cumpleConCaracteristica2(NombrePropiedad, NombrePersona) :-
  usuario(NombrePersona, AmbientesBuscados, Jardin, MetrosCubicosBuscados),
  propiedad(NombrePropiedad, AmbientesPosta, Jardin, MetrosCubicosPosta),
  AmbientesPosta >= AmbientesBuscados,
  MetrosCubicosPosta >= MetrosCubicosBuscados.

cumpleConCaracteristica3(propiedad(NombrePropiedad, AmbientesPosta, Jardin, MetrosCubicosPosta), usuario(NombrePersona, AmbientesBuscados, Jardin, MetrosCubicosBuscados)) :-
  AmbientesPosta >= AmbientesBuscados,
  MetrosCubicosPosta >= MetrosCubicosBuscados.

%cumpleConCaracteristica(Propiedad, Caracteristica) :-
%  Propiedad(_, Ambientes, Jardin, Piscina),
%  Caracteristica(Ambientes, Jardin, Piscina).

%cumpleConCaracteristica(Propiedad, Caracteristica) :-
%  Propiedad(_, Ambientes, Jardin, Piscina),
%  Caracteristica(Ambientes2, Jardin, Piscina2),
%  Ambientes2 >= Ambientes,
%  Piscina2 >= Piscina.

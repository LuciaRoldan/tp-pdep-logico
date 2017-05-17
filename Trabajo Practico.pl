%%%%%%%%%%%%%%%%%%   PROPIEDADES   %%%%%%%%%%%%%%%%%%
%(nombre, ambientes, jardín?, metros cubicos de la piscina)
%Los precios no importan? (700/ 2000/ 1000/ 200)

propiedad(tinsmith_Circle_1774, 3, si, 0).
propiedad(av_Moreno_708, 7, si, 30).
propiedad(av_Siempre_Viva_742, 4, si, 0).
propiedad(calle_Falsa_123, 3, no, 0).


%%%%%%%%%%%%%%%%%%   USUARIOS   %%%%%%%%%%%%%%%%%%
usuario(carlos, 3, si, _).
usuario(ana, _, _, 100).
usuario(maria, 2, _, 15).
usuario(pedro, unosAmbientes, unjardin, unosMetrosCubicos) :-
  usuario(maria, unosAmbientes, unjardin, unosMetrosCubicos).
%Chamaleon:
usuario(chamaleon, unosAmbientes, unjardin, unosMetrosCubicos) :-
  usuario(maria, unosAmbientes, unjardin, unosMetrosCubicos).
usuario(chamaleon, unosAmbientes, unjardin, unosMetrosCubicos) :-
  usuario(carlos, unosAmbientes, unjardin, unosMetrosCubicos).
usuario(chamaleon, unosAmbientes, unjardin, unosMetrosCubicos) :-
  usuario(ana, unosAmbientes, unjardin, unosMetrosCubicos).
usuario(chamaleon, unosAmbientes, unjardin, unosMetrosCubicos) :-
  usuario(pedro, unosAmbientes, unjardin, unosMetrosCubicos).

compararAmbiente(Nombre1, UnosAmbientes, UnJardin, UnosMetrosCubicos) :-
  propiedad(Nombre1, UnosAmbientes, UnJardin, UnosMetrosCubicos),
  propiedad(Nombre2, UnosAmbientes, _, _),
  Nombre1 \= Nombre2.

%cumpleConCaracteristica(Propiedad, Caracteristica) :-
%  Propiedad(_, Ambientes, Jardin, Piscina),
%  Caracteristica(Ambientes, Jardin, Piscina).

%cumpleConCaracteristica(Propiedad, Caracteristica) :-
%  Propiedad(_, Ambientes, Jardin, Piscina),
%  Caracteristica(Ambientes2, Jardin, Piscina2),
%  Ambientes2 >= Ambientes,
%  Piscina2 >= Piscina.

%propiedades
propiedad(tinsmithCircle1774,3,si,0).
propiedad(avMoreno708,7,si,30).
propiedad(avSiempreViva742,4,si,0).
propiedad(calleFalsa123,3,nop,0).
%usuarios
usuario(carlos,3,si,_).
usuario(ana,3,_,100).
usuario(maria,2,_,15).
usuario(pedro,2,_,15).
usuario(chamaleon,_,_,_).

cumpleConCaracteristica(Propiedad,Caracteristica) :-
  Propiedad(_,Ambientes,Jardin,Piscina),
  Caracteristica(Ambientes,Jardin,Piscina).

cumpleConCaracteristica(Propiedad,Caracteristica) :-
  Propiedad(_,Ambientes,Jardin,Piscina),
  Caracteristica(Ambientes2,Jardin,Piscina2),
  Ambientes2 >= Ambientes,
  Piscina2 >= Piscina.

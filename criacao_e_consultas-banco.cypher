//O uso do ""WITH 1 AS dummy é por que ela serve como uma ponte entre as seções do script,
//permitindo que o Neo4j processe cada seção de forma isolada, evitando conflitos ou erros de sintaxe


CREATE (jose:Perfil {nome: 'José', data_nascimento: '01/01/1990', pais: 'País', cidade: 'Cidade', sexo: 'Sexo', religiao: 'Religião', estado_civil: 'Estado Civil'}),
       (mauro:Perfil {nome: 'Mauro', data_nascimento: '02/02/1991', pais: 'País', cidade: 'Cidade', sexo: 'Sexo', religiao: 'Religião', estado_civil: 'Estado Civil'}),
       (leda:Perfil {nome: 'Leda', data_nascimento: '03/03/1992', pais: 'País', cidade: 'Cidade', sexo: 'Sexo', religiao: 'Religião', estado_civil: 'Estado Civil'}),
       (erika:Perfil {nome: 'Erika', data_nascimento: '04/04/1993', pais: 'País', cidade: 'Cidade', sexo: 'Sexo', religiao: 'Religião', estado_civil: 'Estado Civil'}),
       (daniel:Perfil {nome: 'Daniel', data_nascimento: '05/05/1994', pais: 'País', cidade: 'Cidade', sexo: 'Sexo', religiao: 'Religião', estado_civil: 'Estado Civil'}),
       (edilson:Perfil {nome: 'Edilson', data_nascimento: '06/06/1995', pais: 'País', cidade: 'Cidade', sexo: 'Sexo', religiao: 'Religião', estado_civil: 'Estado Civil'}),
       (aline:Perfil {nome: 'Aline', data_nascimento: '07/07/1996', pais: 'País', cidade: 'Cidade', sexo: 'Sexo', religiao: 'Religião', estado_civil: 'Estado Civil'});
WITH 1 AS dummy

MATCH (mauro:Perfil {nome: 'Mauro'})
MATCH (perfil:Perfil)
WHERE perfil.nome <> 'José' AND perfil.nome <> 'Mauro'
CREATE (mauro)-[:AMIGO]->(perfil);
WITH 1 AS dummy

MATCH (leda:Perfil {nome: 'Leda'})
MATCH (perfil:Perfil)
WHERE perfil.nome IN ['Mauro', 'Erika', 'Edilson']
CREATE (leda)-[:AMIGO]->(perfil);
WITH 1 AS dummy

MATCH (erika:Perfil {nome: 'Erika'})
MATCH (perfil:Perfil)
WHERE perfil.nome IN ['Mauro', 'Leda', 'Aline']
CREATE (erika)-[:AMIGO]->(perfil);
WITH 1 AS dummy

MATCH (daniel:Perfil {nome: 'Daniel'})
MATCH (perfil:Perfil)
WHERE perfil.nome IN ['Mauro', 'Edilson', 'Aline']
CREATE (daniel)-[:AMIGO]->(perfil);
WITH 1 AS dummy

MATCH (edilson:Perfil {nome: 'Edilson'})
MATCH (perfil:Perfil)
WHERE perfil.nome IN ['Mauro', 'Leda', 'Daniel']
CREATE (edilson)-[:AMIGO]->(perfil);
WITH 1 AS dummy

MATCH (aline:Perfil {nome: 'Aline'})
MATCH (perfil:Perfil)
WHERE perfil.nome IN ['Daniel', 'Mauro', 'Erika', 'José']
CREATE (aline)-[:AMIGO]->(perfil);
WITH 1 AS dummy

MATCH (jose:Perfil {nome: 'José'})
MATCH (perfil:Perfil)
WHERE perfil.nome = 'Aline'
CREATE (jose)-[:AMIGO]->(perfil);
WITH 1 AS dummy

// Mauro envia uma mensagem de "Bom dia" para todos os amigos
MATCH (mauro:Perfil {nome: 'Mauro'}), (amigo:Perfil)
WHERE (mauro)-[:AMIGO]->(amigo)
CREATE (mensagemBomDia:Mensagem {conteudo: 'Bom dia'}),
       (mauro)-[:ENVIAR_MENSAGEM]->(mensagemBomDia)-[:DESTINATARIO]->(amigo);
WITH 1 AS dummy

// Mauro posta uma foto no perfil
MATCH (mauro:Perfil {nome: 'Mauro'})
CREATE (fotoMauro:Foto {descricao: 'Foto de Mauro'}),
       (mauro)-[:POSTAR_FOTO]->(fotoMauro);
WITH 1 AS dummy

// Amigos comentam a foto de Mauro
MATCH (foto:Foto {descricao: 'Foto de Mauro'}), (amigo:Perfil)
WHERE (amigo)-[:AMIGO]->(:Perfil {nome: 'Mauro'})
CREATE (comentarioFoto:Comentario {conteudo: 'Que foto legal!'}),
       (amigo)-[:COMENTAR_FOTO]->(comentarioFoto)-[:SOBRE]->(foto);
WITH 1 AS dummy

// Aline posta um poema
MATCH (aline:Perfil {nome: 'Aline'})
CREATE (poemaAline:Texto {titulo: 'A Pedra', conteudo: 'Texto do poema...'}),
       (aline)-[:POSTAR_TEXTO]->(poemaAline);
WITH 1 AS dummy

// Amigos comentam o poema de Aline
MATCH (texto:Texto {titulo: 'A Pedra'}), (amigo:Perfil)
WHERE (amigo)-[:AMIGO]->(:Perfil {nome: 'Aline'})
CREATE (comentarioPoema:Comentario {conteudo: 'Adorei seu poema!'}),
       (amigo)-[:COMENTAR_TEXTO]->(comentarioPoema)-[:SOBRE]->(texto);
WITH 1 AS dummy

// Aline envia uma mensagem reclamando para José
MATCH (aline:Perfil {nome: 'Aline'}), (jose:Perfil {nome: 'José'})
CREATE (reclamacaoAline:Mensagem {conteudo: 'Que mensagem chata'}),
       (aline)-[:ENVIAR_MENSAGEM]->(reclamacaoAline)-[:DESTINATARIO]->(jose);
WITH 1 AS dummy

//1. Quais são os amigos dos amigos de José?
MATCH (jose:Perfil {nome: 'José'})-[:AMIGO]->(amigo:Perfil)-[:AMIGO]->(amigoDoAmigo:Perfil)
WHERE NOT (jose)-[:AMIGO]->(amigoDoAmigo) AND jose <> amigoDoAmigo
RETURN jose, amigo, amigoDoAmigo;

//2. Quais amigos de José comentaram a foto de Mauro?
MATCH (jose:Perfil {nome: 'José'})-[:AMIGO]->(amigo:Perfil),
      (amigo)-[relComentario:COMENTAR_FOTO]->(comentario:Comentario)-[:SOBRE]->(foto:Foto),
      (mauro:Perfil {nome: 'Mauro'})-[:POSTAR_FOTO]->(foto)
RETURN jose, amigo, relComentario, comentario, foto, mauro;

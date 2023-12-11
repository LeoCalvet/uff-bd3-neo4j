## Bancos de Dados Orientados a Grafos

Uma possível definição de redes sociais baseia-se no conceito de redes de relacionamentos virtuais. Este tipo de rede tem como objetivo ligar as pessoas que possuem algum grau de afinidade além de proporcionar que estas pessoas interajam entre si. A ligação entre usuários que a rede proporciona pode ser representada por algum tipo de aspecto que relacione as pessoas com, por exemplo, interesses em comum, familiaridades, compartilhamento de algum tipo de trabalho ou até mesmo por simples casualidade. Suponha que tenhamos sete perfis cadastrados na nossa rede de Relacionamento: José, Mauro, Leda, Erika, Daniel, Edilson e Aline. Cada perfil possui as seguintes informações: (i) nome, (ii) data de nascimento, (iii) país, (iv) cidade, (v) sexo, (vi) religião e (vii) estado civil. Agora vamos supor que estes perfis se relacionam da seguinte maneira:

· Mauro é amigo de todos os perfis menos José.
· Leda é amiga apenas dos perfis Mauro, Erika e Edilson;
· Erika é amiga apenas dos perfis Mauro, Leda e Aline;
· Daniel é amigo apenas dos perfis Mauro, Edilson e Aline;
· Edilson é amigo apenas dos perfis Mauro, Leda e Daniel;
· Aline é amiga apenas dos perfis Daniel, Mauro, Érika e José.
· José é amigo apenas de Aline.

Cada perfil pode realizar as seguintes ações: (i) enviar mensagem para outro perfil, (ii) postar um texto, (iii) postar uma foto, (iv) comentar um texto e (v) comentar uma foto. Vamos supor que Mauro enviou uma mensagem "Bom dia" para todos seus amigos e postou sua foto no seu perfil. Todos os seus amigos comentaram a foto de Mauro. Aline postou um poema chamado "A Pedra" em seu perfil. Todos os seus amigos comentaram o poema de Aline. Aline enviou uma mensagem a José reclamando da mensagem de bom dia de Mauro "Que mensagem chata".

Modele o cenário acima como um grafo no SGBD Neo4J. Elabore consultas para os itens a seguir:

1. Quais são os amigos dos amigos de José?
2. Quais amigos de José comentaram a foto de Mauro?

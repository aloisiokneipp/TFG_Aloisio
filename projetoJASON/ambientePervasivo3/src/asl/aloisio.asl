// Agent aloisio in project ambientePervasivo3

/* Os ambientes possuem como atributos descri��o, localiza��o (casa, apartamento, escrit�rio, loja), 
 * ilumina��o (est�gios - fraco, medio, forte), modo  (inverno, verao, ventilar, secar) e temperatura. 
 * Finalmente, a rela��o usu�rio com climatiza��o, por exemplo, 
 * possui os campos usu�rio, ambiente, horario (manh�, tarde, noite), modo e temperatura.
 */
 
/* Initial beliefs and rules */
//crencas vem do servidor e convertidas em arquivo texto

//CLIMATIZACAO
//peca1 - quarto de dormir
casa1_peca1_climatizacao(verao, noite, 24).
casa1_peca1_climatizacao(verao, tarde, 18).
casa1_peca1_climatizacao(inverno, noite, 26).
casa1_peca1_climatizacao(inverno, tarde, 21).

//peca2 - escritorio
casa1_peca2_climatizacao(verao, tarde, 22).
casa1_peca2_climatizacao(inverno, tarde, 22).

//ILUMINACAO
//peca1 - quarto de dormir
casa1_peca1_iluminacao(fraca,noite).
casa1_peca1_iluminacao(media,tarde).

//peca2 - escritorio
casa1_peca2_iluminacao(forte,manha).
casa1_peca2_iluminacao(forte,tarde).
casa1_peca2_iluminacao(forte,noite).


/*initials plans */
+peca1(Agente): Agente == aloisio & contexto(Estacao,Turno) 
	<- 
		.print("vou avisar a peca1 o meu perfil");
		 ?casa1_peca1_climatizacao(Estacao, Turno, Temperatura);
		.send(peca1_climatizacao,tell, casa1_peca1_climatizacao(Estacao,Turno,Temperatura));
		?casa1_peca1_iluminacao(Estagio,Turno);
		.send(peca1_iluminacao,tell, casa1_peca1_iluminacao(Estagio,Turno)).

+peca1(Agente): Agente == aloisio & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").

+peca2(Agente): Agente == aloisio & contexto(Estacao,Turno) 
	<- 
		.print("vou avisar a peca2 o meu perfil");
		 ?casa1_peca2_climatizacao(Estacao, Turno, Temperatura);
		.send(peca2_climatizacao,tell, casa1_peca2_climatizacao(Estacao,Turno,Temperatura));
		?casa1_peca2_iluminacao(Estagio,Turno); 
		.send(peca2_iluminacao,tell, casa1_peca2_iluminacao(Estagio,Turno)).

+peca2(Agente): Agente == aloisio & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").
		
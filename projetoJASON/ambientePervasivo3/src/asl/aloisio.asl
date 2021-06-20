// Agent aloisio in project ambientePervasivo3

/* Os ambientes possuem como atributos descrição, localização (casa, apartamento, escritório, loja), 
 * iluminação (estágios - fraco, medio, forte), modo  (inverno, verao, ventilar, secar) e temperatura. 
 * Finalmente, a relação usuário com climatização, por exemplo, 
 * possui os campos usuário, ambiente, horario (manhã, tarde, noite), modo e temperatura.
 */
 
/* Initial beliefs and rules */
//crencas vem do servidor e convertidas em arquivo texto

//CLIMATIZACAO
//peca1 - quarto de dormir
casa1_peca1_climatizacao(aloisio,verao, noite, 24).
casa1_peca1_climatizacao(aloisio,verao, tarde, 18).
casa1_peca1_climatizacao(aloisio,inverno, noite, 26).
casa1_peca1_climatizacao(aloisio,inverno, tarde, 21).

//peca2 - escritorio
casa1_peca2_climatizacao(aloisio,verao, tarde, 22).
casa1_peca2_climatizacao(aloisio,inverno, tarde, 22).

//ILUMINACAO
//peca1 - quarto de dormir
casa1_peca1_iluminacao(aloisio,fraca,noite).
casa1_peca1_iluminacao(aloisio,fraca,tarde).

//peca2 - escritorio
casa1_peca2_iluminacao(aloisio,forte,manha).
casa1_peca2_iluminacao(aloisio,forte,tarde).
casa1_peca2_iluminacao(aloisio,forte,noite).

/*initials plans */
+peca1(Usuario): Usuario == aloisio & contexto(Estacao,Turno) 
	<- 
		?casa1_peca1_climatizacao(Usuario,Estacao, Turno, Temperatura);
		?casa1_peca1_iluminacao(Usuario,Estagio,Turno);
		.print("avisando peca1 o meu perfil....Temperatura: ", Temperatura, ". Iluminação: ", Estagio);
		.send(peca1_climatizacao,tell, casa1_peca1_climatizacao(Usuario, Estacao,Turno,Temperatura));
		.send(peca1_iluminacao,tell, casa1_peca1_iluminacao(Usuario, Estagio,Turno)).
		
+peca1(Usuario): Usuario == aloisio & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").
		
+peca2(Usuario): Usuario == aloisio & contexto(Estacao,Turno) 
	<- 
		?casa1_peca2_climatizacao(Usuario,Estacao, Turno, Temperatura);
		?casa1_peca2_iluminacao(Usuario,Estagio,Turno);
		.print("avisando peca2 o meu perfil....Temperatura: ", Temperatura, ". Iluminação: ", Estagio);
		.send(peca2_climatizacao,tell, casa1_peca2_climatizacao(Usuario, Estacao,Turno,Temperatura));
		.send(peca2_iluminacao,tell, casa1_peca2_iluminacao(Usuario, Estagio,Turno)).
		
+peca2(Usuario): Usuario == aloisio & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").
		

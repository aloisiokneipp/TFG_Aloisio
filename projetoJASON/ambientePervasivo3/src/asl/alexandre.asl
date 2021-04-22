// Agent alexandre in project ambientePervasivo3

//crencas vem do servidor e convertidas em arquivo texto

//CLIMATIZACAO
//peca1 - quarto de dormir
casa1_peca1_climatizacao(verao, noite, 26).
casa1_peca1_climatizacao(verao, tarde, 24).
casa1_peca1_climatizacao(inverno, noite, 20).
casa1_peca1_climatizacao(inverno, tarde, 24).

//peca2 - escritorio
casa1_peca2_climatizacao(verao, tarde, 26).
casa1_peca2_climatizacao(inverno, tarde, 20).

//ILUMINACAO
//peca1 - quarto de dormir
casa1_peca1_iluminacao(media,noite).
casa1_peca1_iluminacao(fraca,tarde).

//peca2 - escritorio
casa1_peca2_iluminacao(media,manha).
casa1_peca2_iluminacao(media,tarde).
casa1_peca2_iluminacao(media,noite).

/*initials plans */
+peca1(alexandre): contexto(Estacao,Turno) 
	<- 
		.print("vou avisar a peca1 o meu perfil");
		 ?casa1_peca1_climatizacao(Estacao, Turno, Temperatura);
		.send(peca1_climatizacao,tell, casa1_peca1_climatizacao(Estacao,Turno,Temperatura));
		?casa1_peca1_iluminacao(Estagio,Turno);
		.send(peca1_iluminacao,tell, casa1_peca1_iluminacao(Estagio,Turno)).
		
+peca1(Agente): Agente == alexandre & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").
		
+peca2(alexandre): contexto(Estacao,Turno) 
	<- 
		.print("vou avisar a peca2 o meu perfil");
		 ?casa1_peca2_climatizacao(Estacao, Turno, Temperatura);
		.send(peca2_climatizacao,tell, casa1_peca2_climatizacao(Estacao,Turno,Temperatura));
		?casa1_peca2_iluminacao(Estagio,Turno); 
		.send(peca2_iluminacao,tell, casa1_peca2_iluminacao(Estagio,Turno)).
		
+peca2(Agente): Agente == alexandre & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").
		

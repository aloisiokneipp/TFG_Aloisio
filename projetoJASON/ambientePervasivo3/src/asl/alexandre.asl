// Agent alexandre in project ambientePervasivo3

//crencas vem do servidor e convertidas em arquivo texto

//CLIMATIZACAO
//peca1 - quarto de dormir
casa1_peca1_climatizacao(alexandre,verao, noite, 26).
casa1_peca1_climatizacao(alexandre,verao, tarde, 24).
casa1_peca1_climatizacao(alexandre,inverno, noite, 20).
casa1_peca1_climatizacao(alexandre,inverno, tarde, 24).

//peca2 - escritorio
casa1_peca2_climatizacao(alexandre,verao, tarde, 26).
casa1_peca2_climatizacao(alexandre,inverno, tarde, 20).

//ILUMINACAO
//peca1 - quarto de dormir
casa1_peca1_iluminacao(alexandre,media,noite).
casa1_peca1_iluminacao(alexandre,media,tarde).

//peca2 - escritorio
casa1_peca2_iluminacao(alexandre,media,manha).
casa1_peca2_iluminacao(alexandre,media,tarde).
casa1_peca2_iluminacao(alexandre,media,noite).

/*initials plans */
+peca1(Usuario): Usuario == alexandre & contexto(Estacao,Turno) 
	<- 
		?casa1_peca1_climatizacao(Usuario,Estacao, Turno, Temperatura);
		?casa1_peca1_iluminacao(Usuario,Estagio,Turno);
		.print("avisando peca1 o meu perfil....Temperatura: ", Temperatura, ". Iluminação: ", Estagio);
		.send(peca1_climatizacao,tell, casa1_peca1_climatizacao(Usuario, Estacao,Turno,Temperatura));
		.send(peca1_iluminacao,tell, casa1_peca1_iluminacao(Usuario, Estagio,Turno)).
		
+peca1(Usuario): Usuario == alexandre & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").
		
+peca2(Usuario): Usuario == alexandre & contexto(Estacao,Turno) 
	<- 
		?casa1_peca2_climatizacao(Usuario,Estacao, Turno, Temperatura);
		?casa1_peca2_iluminacao(Usuario,Estagio,Turno);
		.print("avisando peca2 o meu perfil....Temperatura: ", Temperatura, ". Iluminação: ", Estagio);
		.send(peca2_climatizacao,tell, casa1_peca2_climatizacao(Usuario, Estacao,Turno,Temperatura));
		.send(peca2_iluminacao,tell, casa1_peca2_iluminacao(Usuario, Estagio,Turno)).
		
+peca2(Usuario): Usuario == alexandre & contexto(Estacao,Turno) 
	<- 
		.print("Nao tenho perfil para esta estacao ou turno").
		

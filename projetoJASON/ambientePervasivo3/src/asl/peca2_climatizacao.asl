// Agent peca2_climatizacao in project ambientePervasivo3

/* Initial beliefs and rules */

/* Initial goals */

//!start.

/* Plans */

+!start : true <- .print("Sou um agente de climatizacao").


+peca2(Usuario): peca2(OutroUsuario) & Usuario \== OutroUsuario
	<- .print("Notei que outro usuario ", Usuario, " entrou no recinto...... vou precisar negociar a temperatura"); 
	   ?casa1_peca2_climatizacao(_,_,TemperaturaUsuario);
	   ?casa1_peca2_climatizacao(_,_,TemperaturaOutroUsuario);
	   TemperaturaAtual is (TemperaturaUsuario + TemperaturaOutroUsuario)/2;
	   .wait(300);
	   configurar(Temperatura).
	   	   
	   
+peca2(Usuario): true
	<- .print("Notei que ", Usuario, " entrou no recinto.");
		.wait(300);
	   ?casa1_peca2_climatizacao(Estacao,Turno,Temperatura);
	   configurar(Temperatura).
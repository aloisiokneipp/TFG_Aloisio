// Agent climatizacao in project ambientePervasivo3

/* Initial beliefs and rules */

/* Initial goals */

//!start.

/* Plans */
+!start : true <- .print("Sou um agente de climatizacao").

+peca1(Usuario): peca1(OutroUsuario) & Usuario \== OutroUsuario
	<- .print("Notei que outro usuario ", Usuario, " entrou no recinto...... vou precisar negociar a temperatura");
	   ?casa1_peca1_climatizacao(_,_,TemperaturaUsuario);
	   ?casa1_peca1_climatizacao(_,_,TemperaturaOutroUsuario);
	   TemperaturaAtual is (TemperaturaUsuario + TemperaturaOutroUsuario)/2;
	   .wait(300);
	   configurar(Temperatura).
	   
	      

+peca1(Usuario): true
	<- .print("Notei que ", Usuario, " entrou no recinto.");
	   .wait(300);
	   ?casa1_peca1_climatizacao(Estacao,Turno,Temperatura);
	   configurar(Temperatura).
	   
	   
	   
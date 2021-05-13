// Agent climatizacao in project ambientePervasivo3
/* Initial beliefs and rules */
/* Initial goals */
//!start.
/* Plans */
+!start : true <- .print("Sou um agente de climatizacao").

+peca1(Usuario): peca1(OutroUsuario) & Usuario \== OutroUsuario & casa1_peca1_climatizacao(OutroUsuario,_,_,TemperaturaOutroUsuario)		 
	<- .print("Notei que outro usuario ", Usuario, " entrou no recinto...... vou precisar negociar a temperatura");
	   .wait(300);
	   ?casa1_peca1_climatizacao(Usuario,Estacao,Turno,TemperaturaUsuario);
	   TemperaturaAtual = (TemperaturaUsuario + TemperaturaOutroUsuario)/2;
       .print("A temperatura negociada foi ....", TemperaturaAtual);	  
	   configurarTemperatura(TemperaturaAtual).
	   
+peca1(Usuario): true
	<- .print("Notei que ", Usuario, " entrou no recinto.");
	   .wait(300);
	   ?casa1_peca1_climatizacao(Usuario,Estacao,Turno,Temperatura);
	   configurarTemperatura(Temperatura).
	   
-peca1(Usuario): true
	<- .print("o ", Usuario, " saiu daqui.... vou decidir se irei ou não desligar o arcondicionado").
	   
	   
	   
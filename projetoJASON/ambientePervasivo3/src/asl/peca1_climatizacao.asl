// Agent climatizacao in project ambientePervasivo3
/* Initial beliefs and rules */
/* Initial goals */
//!start.
/* Plans */
+!start : true <- .print("Sou um agente de climatizacao").

+peca1(Usuario): peca1(Usuario2) & Usuario \== Usuario2 & peca1(Usuario3) & Usuario \== Usuario3 & Usuario2 \== Usuario3 &
                 casa1_peca1_climatizacao(Usuario2,_,_,TemperaturaUsuario2) & casa1_peca1_climatizacao(Usuario3,_,_,TemperaturaUsuario3)	 
	<- .print("Notei que um terceiro usuario ", Usuario, " entrou no recinto...... vou precisar negociar a temperatura");
	   .wait(3000);
	   ?casa1_peca1_climatizacao(Usuario,Estacao,Turno,TemperaturaUsuario);
	   TemperaturaAtual = (TemperaturaUsuario + TemperaturaUsuario2 + TemperaturaUsuario3)/3;
       .print("A temperatura negociada foi ....", TemperaturaAtual);	  
	   configurarTemperatura(TemperaturaAtual).

+peca1(Usuario): peca1(OutroUsuario) & Usuario \== OutroUsuario & casa1_peca1_climatizacao(OutroUsuario,_,_,TemperaturaOutroUsuario)		 
	<- .print("Notei que um segundo usuario ", Usuario, " entrou no recinto...... vou precisar negociar a temperatura");
	   .wait(3000);
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
	   
	   
	   
	   
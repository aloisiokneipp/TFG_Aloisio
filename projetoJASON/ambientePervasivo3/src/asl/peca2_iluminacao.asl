// Agent peca2_iluminacao in project ambientePervasivo3
/* Initial beliefs and rules */
/* Initial goals */
//!start.
/* Plans */
+!start : true <- .print("Sou um agente de iluminacao").

+peca2(Usuario): peca2(OutroUsuario) & Usuario \== OutroUsuario & casa1_peca2_iluminacao(OutroUsuario,EstagioOutroUsuario,Turno)				 
	<- .print("Notei que um segundo usuario ", Usuario, " entrou no recinto...... vou precisar negociar a ilumina��o");
	   .wait(3000);
	   ?casa1_peca2_iluminacao(Usuario,EstagioUsuario,Turno);
	   !negociarIluminacao2(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario);
       .print("A ilumina��o negociada foi ....", IluminacaoAtual);	  
	   configurarIluminacao(IluminacaoAtual).  	   

+!negociarIluminacao2(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario): EstagioUsuario == EstagioOutroUsuario
	<- IluminacaoAtual = EstagioUsuario.

+!negociarIluminacao2(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario): true
	<- IluminacaoAtual = media.

+peca2(Usuario): true
	<- .print("Notei que ", Usuario, " entrou no recinto.");
	   .wait(300);
	   ?casa1_peca2_iluminacao(Usuario,Estagio,Turno);
	   configurarIluminacao(Estagio).

+peca2(Usuario): peca2(Usuario2) & Usuario \== Usuario2 & peca2(Usuario3) & Usuario \== Usuario3 & Usuario2 \== Usuario3 &
                 casa1_peca2_iluminacao(Usuario2,EstagioUsuario2,Turno) & casa1_peca2_iluminacao(Usuario3,EstagioUsuario3,Turno)	 
	<- .print("Notei que um terceiro usuario ", Usuario, " entrou no recinto...... vou precisar negociar a ilumina��o");
	   .wait(3000);
	   ?casa1_peca2_iluminacao(Usuario,EstagioUsuario,Turno);
	   !negociarIluminacao3(IluminacaoAtual,EstagioUsuario,EstagioUsuario2,EstagioUsuario3);
       .print("A ilumina��o negociada foi ....", IluminacaoAtual);	  
       .wait(1000);
	   configurarIluminacao(IluminacaoAtual).
	   
+!negociarIluminacao3(IluminacaoAtual,EstagioUsuario,EstagioUsuario2,EstagioUsuario3): EstagioUsuario == EstagioUsuario2 &
                                                                                      EstagioUsuario2 == EstagioUsuario3
	<- IluminacaoAtual = EstagioUsuario.

+!negociarIluminacao3(IluminacaoAtual,EstagioUsuario,EstagioUsuario2,EstagioUsuario3): true
	<- IluminacaoAtual = media.	 
	   
-peca2(Usuario): true
	<- .print("o ", Usuario, " saiu daqui.... vou decidir se irei ou n�o desligar a ilumina��o").
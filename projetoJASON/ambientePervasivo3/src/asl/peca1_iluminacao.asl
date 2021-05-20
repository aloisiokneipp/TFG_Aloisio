// Agent iluminacao in project ambientePervasivo3
/* Initial beliefs and rules */
/* Initial goals */
//!start.
/* Plans */
+!start : true <- .print("Sou um agente de iluminacao").

+peca1(Usuario): peca1(OutroUsuario) & Usuario \== OutroUsuario & casa1_peca1_iluminacao(OutroUsuario,EstagioOutroUsuario,Turno)
	<- .print("Notei que um segundo usuario ", Usuario, " entrou no recinto...... vou precisar negociar a iluminação");
	   .wait(3000);
	   ?casa1_peca1_iluminacao(Usuario,EstagioUsuario,Turno);
	   !negociarIluminacao2(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario);
       .print("A iluminação negociada foi ....", IluminacaoAtual);	  
       .wait(1000);
	   configurarIluminacao(IluminacaoAtual).
	   
+!negociarIluminacao2(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario): EstagioUsuario == EstagioOutroUsuario
	<- IluminacaoAtual = EstagioUsuario.

+!negociarIluminacao2(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario): true
	<- IluminacaoAtual = media.

+peca1(Usuario): true
	<- .print("Notei que ", Usuario, " entrou no recinto.");
	   .wait(300);
	   ?casa1_peca1_iluminacao(Usuario,Estagio,Turno);
	   .wait(1000);
	   configurarIluminacao(Estagio).
	   
+peca1(Usuario): peca1(Usuario2) & Usuario \== Usuario2 & peca1(Usuario3) & Usuario \== Usuario3 & Usuario2 \== Usuario3 &
                 casa1_peca1_iluminacao(Usuario2,EstagioUsuario2,Turno) & casa1_peca1_iluminacao(Usuario3,EstagioUsuario3,Turno)	 
	<- .print("Notei que um terceiro usuario ", Usuario, " entrou no recinto...... vou precisar negociar a iluminação");
	   .wait(3000);
	   ?casa1_peca1_iluminacao(Usuario,EstagioUsuario,Turno);
	   !negociarIluminacao3(IluminacaoAtual,EstagioUsuario,EstagioUsuario2,EstagioUsuario3);
       .print("A iluminação negociada foi ....", IluminacaoAtual);	  
       .wait(1000);
	   configurarIluminacao(IluminacaoAtual).
	   

+!negociarIluminacao3(IluminacaoAtual,EstagioUsuario,EstagioUsuario2,EstagioUsuario3): EstagioUsuario == EstagioUsuario2 &
                                                                                      EstagioUsuario2 == EstagioUsuario3
	<- IluminacaoAtual = EstagioUsuario.

+!negociarIluminacao3(IluminacaoAtual,EstagioUsuario,EstagioUsuario2,EstagioUsuario3): true
	<- IluminacaoAtual = media.
	   
-peca1(Usuario): true
	<- .print("o ", Usuario, " saiu daqui.... vou decidir se irei ou não desligar a iluminação").
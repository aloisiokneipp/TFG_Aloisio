// Agent peca2_iluminacao in project ambientePervasivo3

/* Initial beliefs and rules */

/* Initial goals */

//!start.

/* Plans */

+!start : true <- .print("Sou um agente de iluminacao").


+peca2(Usuario): peca1(OutroUsuario) & Usuario \== OutroUsuario & casa1_peca2_iluminacao(OutroUsuario,EstagioOutroUsuario,Turno)
				 
	<- .print("Notei que outro usuario ", Usuario, " entrou no recinto...... vou precisar negociar a iluminação");
	   .wait(300);
	   ?casa1_peca2_iluminacao(Usuario,EstagioUsuario,Turno);

	   !negociarIluminacao(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario);
	   
       .print("A iluminação negociada foi ....", IluminacaoAtual).	  
	  // configurarIluminacao(IluminacaoAtual).
	   
+!negociarIluminacao(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario): EstagioUsuario == EstagioOutroUsuario
	<- IluminacaoAtual = EstagioUsuario.

+!negociarIluminacao(IluminacaoAtual,EstagioUsuario,EstagioOutroUsuario): true
	<- IluminacaoAtual = media.

+peca2(Usuario): true
	<- .print("Notei que ", Usuario, " entrou no recinto.");
	   .wait(300);
	   ?casa1_peca2_iluminacao(Usuario,Estagio,Turno).
	   //configurarIluminacao(Estagio).
	   
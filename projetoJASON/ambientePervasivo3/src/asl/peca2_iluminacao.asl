// Agent peca2_iluminacao in project ambientePervasivo3

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("Sou um agente de iluminacao").


+peca2(Usuario): true
	<- .print("Notei que ", Usuario, " entrou no recinto.").
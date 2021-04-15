// Agent usuario in project ambientePervasivo3

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- 
	.wait(2000);
	.print("Sou um usuário do sistema com perfis específicos de climatização e iluminação").

// Agent aloisio in project ambientePervasivo3

/* Os ambientes possuem como atributos descrição, localização (casa, apartamento, escritório, loja), 
 * iluminação (estágios - fraco, médio, forte), modo  (inverno, verão, ventilar, secar) e temperatura. 
 * Finalmente, a relação usuário com climatização, por exemplo, 
 * possui os campos usuário, ambiente, horário (manhã, tarde, noite), modo e temperatura.
 */
 
/* Initial beliefs and rules */
//crenças vem do servidor e convertidas em arquivo texto

//CLIMATIZACAO
//peca1 - quarto de dormir
casa1_peca1_climatizacao(verao, noite, 24).
casa1_peca1_climatizacao(verao, tarde, 18).
casa1_peca1_climatizacao(inverno, noite, 26).
casa1_peca1_climatizacao(inverno, tarde, 21).

//peca2 - escritório
casa1_peca2_climatizacao(verao, tarde, 22).
casa1_peca2_climatizacao(inverno, tarde, 22).

//ILUMINACAO
//peca1 - quarto de dormir
casa1_peca1_iluminacao(fraca,noite).

//peca2 - escritório
casa1_peca2_iluminacao(forte,manha).
casa1_peca2_iluminacao(forte,tarde).
casa1_peca2_iluminacao(forte,noite).


/* Initial goals */


/* Plans */



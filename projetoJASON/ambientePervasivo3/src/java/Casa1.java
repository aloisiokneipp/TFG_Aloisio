// Environment code for project ambientePervasivo3

import jason.asSyntax.*;
import jason.environment.*;
import jason.asSyntax.parser.*;

import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import java.util.logging.*;

public class Casa1 extends Environment {

    private Logger logger = Logger.getLogger("ambientePervasivo3."+Casa1.class.getName());

    private String sorteiaUsuarioPeca() {
    	Random gerador = new Random();
    	StringBuffer peca = new StringBuffer();
    	peca.append("peca");
    	
    	//definindo a peca.... vem do servidor .... quarto, sala, escritório
    	List<String> listaPecas = new LinkedList<String>(); //populada do servidor
    	
    	listaPecas.add("Quarto de Dormir");
    	listaPecas.add("Escritorio"); 
    	
    	int numero = gerador.nextInt(listaPecas.size())+1;
    	
    	peca.append(numero+"(");
    	
    	//definindo o usuario.... vem do servidor .... alosio, alexandre, reiner ou ricardo
    	List<String> listaUsuarios = new LinkedList<String>();
    	listaUsuarios.add("aloisio"); //nome tratado, capturado primeiro nome e transformado em minúsculo
    	listaUsuarios.add("alexandre"); //nome tratado, capturado primeiro nome e transformado em minúsculo
    	//listaUsuarios.add("alexandre"); //nome tratado, capturado primeiro nome e transformado em minúsculo
    	String usuario = listaUsuarios.get(gerador.nextInt(listaUsuarios.size()));
    	
    	peca.append(usuario+")");
    	return peca.toString();
    }
    	
    private String sorteiaEstacaoTurno() {
    	Random gerador = new Random();
    	StringBuffer contexto = new StringBuffer();
    	contexto.append("contexto(");
    	switch (gerador.nextInt(4)) {
    		case 0: //verao
    				contexto.append("verao,");
    				break;
    		case 1: //outono
    				contexto.append("outono,");
    				break;
    		case 2: //inverno
	    			contexto.append("inverno,");
					break;
    		case 3: //primavera
	    			contexto.append("primavera,");
	    			break;
    	}
    	
    	switch (gerador.nextInt(3)) {
			case 0: //manha
					contexto.append("manha");
					break;
			case 1: //tarde
					contexto.append("tarde");
					break;
			case 2: //noite
	    			contexto.append("noite");
					break;
		}
    	
    	contexto.append(")");
    	return contexto.toString();
    }
    
    /** Called before the MAS execution with the args informed in .mas2j */
    @Override
    public void init(String[] args) {
        super.init(args);
        try {
			//addPercept(ASSyntax.parseLiteral(sorteiaEstacaoTurno()));
        	addPercept(ASSyntax.parseLiteral("contexto(verao,tarde)"));
			addPercept(ASSyntax.parseLiteral(sorteiaUsuarioPeca()));
		} catch (ParseException e) {
			e.printStackTrace();
		}
    }

    private int extrairTemperatura(String acao) {
    	int temperatura =0;
    	
    	int inicio = acao.indexOf("(");
    	int fim = acao.indexOf(")");
    	
    	temperatura = Integer.parseInt(acao.substring(inicio+1, fim));
    	
    	return temperatura;
    }
        
    @Override
    public boolean executeAction(String agName, Structure action) {
       // logger.info("executing: "+action+", but not implemented!");
    	int temperatura = extrairTemperatura(action.toString());
        if (agName.equals("peca1_climatizacao")) {
        	
             System.out.println("[AMBIENTE FISICO] " + agName + " configurando a temperatura em " + temperatura + " graus");
             //acionar o rele desta pe�a
        }
        
        if (agName.equals("peca2_climatizacao")) {
        	
            System.out.println("[AMBIENTE FISICO] " + agName + " configurando a temperatura em " + temperatura + " graus");
            //acionar o rele desta pe�a
       }
        return true; // the action was executed with success
    }

    /** Called before the end of MAS execution */
    @Override
    public void stop() {
        super.stop();
    }
}

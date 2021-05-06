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
    
    //definindo a peca.... vem do servidor .... quarto, sala, escritório
	public List<String> listaPecas = new LinkedList<String>(); //populada do servidor
	
	//definindo o usuario.... vem do servidor .... alosio, alexandre, reiner ou ricardo
	public List<String> listaUsuarios = new LinkedList<String>();
	
	public StringBuffer pecaAtual = new StringBuffer();
	
	public String usuarioSorteado;
	
	private void capturaUsuarioDoServidor(List<String> listaUsuarios) {
		listaUsuarios.add("aloisio"); //nome tratado, capturado primeiro nome e transformado em minusculo
    	listaUsuarios.add("alexandre"); //nome tratado, capturado primeiro nome e transformado em minusculo
	}
	private void capturaPecasDoServidor(List<String> listaPecas) {
		listaPecas.add("Quarto de Dormir");
    	listaPecas.add("Escritorio");
	}
	
    private String sorteiaUsuarioPeca() {
    	Random gerador = new Random();
    	StringBuffer pecaSorteada = new StringBuffer();
    	
    	pecaSorteada.append("peca");  	
    	pecaAtual.append("peca");
    	 
    	capturaPecasDoServidor(listaPecas);
    	
    	int numero = gerador.nextInt(listaPecas.size())+1;
    	pecaSorteada.append(numero+"(");
     	pecaAtual.append(numero+"(");
   	
     	capturaUsuarioDoServidor(listaUsuarios);
     	
    	usuarioSorteado = listaUsuarios.get(gerador.nextInt(listaUsuarios.size()));
    	
    	pecaSorteada.append(usuarioSorteado+")");
    	
    	return pecaSorteada.toString();
    }
    
    private String sorteiaUsuarioNaMesmaPeca() {
    	Random gerador = new Random();
    	StringBuffer peca = new StringBuffer();
    	peca.append(pecaAtual);
    	
    	String usuario;
    	int contador = 0;
    	do {
    		usuario = listaUsuarios.get(gerador.nextInt(listaUsuarios.size()));
    		contador++;
    		if (contador == 10) {
    			return "erro";
    		}
    	} while (usuario.equals(usuarioSorteado) );
    	
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
    
    private String extrairEstagioIluminacao(String acao) {
    	String iluminacao = "fraca";
    	
    	int inicio = acao.indexOf("(");
    	int fim = acao.indexOf(")");
    	
    	iluminacao = acao.substring(inicio+1, fim);
    	
    	return iluminacao;
    }
        
    @Override
    public boolean executeAction(String agName, Structure action) {
       // logger.info("executing: "+action+", but not implemented!");
    	int temperatura = 0;
    	String iluminacao = "fraca";
    	
    	if (action.toString().contains("Temperatura")) {
    		temperatura = extrairTemperatura(action.toString());
    	}
    	if (action.toString().contains("Iluminacao")) {
    		iluminacao = extrairEstagioIluminacao(action.toString());
    	}
    	
    	
        if (agName.equals("peca1_climatizacao")) {
        	
             System.out.println("[AMBIENTE FISICO] " + agName + " configurando a temperatura em " + temperatura + " graus");
             //acionar o rele desta peça
        }
        
        if (agName.equals("peca2_climatizacao")) {
        	
            System.out.println("[AMBIENTE FISICO] " + agName + " configurando a temperatura em " + temperatura + " graus");
            //acionar o rele desta peça
        }
        
        if (agName.equals("peca1_iluminacao")) {
        	
            System.out.println("[AMBIENTE FISICO] " + agName + " configurando a iluminacao como " + iluminacao);
            //acionar o rele desta peça
       }
       
       if (agName.equals("peca2_iluminacao")) {
       	
           System.out.println("[AMBIENTE FISICO] " + agName + " configurando a iluminacao como " + iluminacao);
           //acionar o rele desta peça
       }
        
        try { 
        	String usuario = sorteiaUsuarioNaMesmaPeca();
        	if (!usuario.equals("erro")) {
        		addPercept(ASSyntax.parseLiteral(usuario));
        	}
		} catch (ParseException e) {
			
		}
		
        return true; // the action was executed with success
    }

    /** Called before the end of MAS execution */
    @Override
    public void stop() {
        super.stop();
    }
}

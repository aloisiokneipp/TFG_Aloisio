// Environment code for project ambientePervasivo3

import jason.asSyntax.*;
import jason.environment.*;
import netscape.javascript.JSException;
import netscape.javascript.JSObject;
import jason.asSyntax.parser.*;

import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import java.util.logging.*;

import ambientePervasivo3.Comunicacao;

public class Casa1 extends Environment {

	private Logger logger = Logger.getLogger("ambientePervasivo3." + Casa1.class.getName());

	// definindo a peca.... vem do servidor .... quarto, sala, escritório
	public List<String> listaPecas = new LinkedList<String>(); // populada do servidor

	// definindo o usuario.... vem do servidor .... alosio, alexandre, reiner ou
	// ricardo
	public List<String> listaUsuarios = new LinkedList<String>();

	public List<UsuarioPeca> listaUsuarioPeca = new LinkedList<UsuarioPeca>();

	public StringBuffer pecaAtual = new StringBuffer();

	public String usuarioSorteado;

	public int quantidadeAcoesPeca1 = 0;
	public int quantidadeAcoesPeca2 = 0;

	public String endereco_arcondicionado = "http://192.168.1.120:8081/zeroconf/switch";
	public String endereco_iluminacao3 = "http://192.168.1.121:8081/zeroconf/switch";
	public String endereco_iluminacao1 = "http://192.168.1.122:8081/zeroconf/switch";
	public String endereco_iluminacao2 = "http://192.168.1.123:8081/zeroconf/switch";

	private void capturaUsuarioDoServidor(List<String> listaUsuarios) {
		listaUsuarios.add("aloisio"); // nome tratado, capturado primeiro nome e transformado em minusculo
		listaUsuarios.add("alexandre"); // nome tratado, capturado primeiro nome e transformado em minusculo
		listaUsuarios.add("ricardo"); // nome tratado, capturado primeiro nome e transformado em minusculo

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
		int numero = gerador.nextInt(listaPecas.size()) + 1;
		capturaUsuarioDoServidor(listaUsuarios);
		usuarioSorteado = listaUsuarios.get(gerador.nextInt(listaUsuarios.size()));
		pecaSorteada.append(numero + "(");

		// para poder simular a saida de um usuario de uma peca
		listaUsuarioPeca.add(new UsuarioPeca(usuarioSorteado, pecaSorteada.toString()));

		pecaAtual.append(numero + "(");
		pecaSorteada.append(usuarioSorteado + ")");

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
			if (contador == 100) {
				return "erro";
			}
		} while (usuario.equals(usuarioSorteado));

		listaUsuarioPeca.add(new UsuarioPeca(usuario, pecaAtual.toString()));

		peca.append(usuario + ")");
		return peca.toString();
	}

	private String retiraUsuarioNaMesmaPeca() {
		Random gerador = new Random();
		StringBuffer peca = new StringBuffer();
		peca.append(pecaAtual);

		if (listaUsuarioPeca.size() == 0)
			return "erro";

		String usuario = listaUsuarioPeca.get(gerador.nextInt(listaUsuarioPeca.size())).usuario;

		peca.append(usuario + ")");
		return peca.toString();
	}

	private String sorteiaEstacaoTurno() {
		Random gerador = new Random();
		StringBuffer contexto = new StringBuffer();
		contexto.append("contexto(");
		switch (gerador.nextInt(4)) {
		case 0: // verao
			contexto.append("verao,");
			break;
		case 1: // outono
			contexto.append("outono,");
			break;
		case 2: // inverno
			contexto.append("inverno,");
			break;
		case 3: // primavera
			contexto.append("primavera,");
			break;
		}
		switch (gerador.nextInt(3)) {
		case 0: // manha
			contexto.append("manha");
			break;
		case 1: // tarde
			contexto.append("tarde");
			break;
		case 2: // noite
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
			// addPercept(ASSyntax.parseLiteral(sorteiaEstacaoTurno()));
			addPercept(ASSyntax.parseLiteral("contexto(verao,tarde)"));
			addPercept(ASSyntax.parseLiteral(sorteiaUsuarioPeca()));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	private int extrairTemperatura(String acao) {
		double temperatura = 0;
		int inicio = acao.indexOf("(");
		int fim = acao.indexOf(")");
		temperatura = Double.parseDouble(acao.substring(inicio + 1, fim));
		return (int) temperatura;
	}

	private String extrairEstagioIluminacao(String acao) {
		String iluminacao = "fraca";
		int inicio = acao.indexOf("(");
		int fim = acao.indexOf(")");
		iluminacao = acao.substring(inicio + 1, fim);
		return iluminacao;
	}

	private String extrairUsuario(String sentenca) {
		String usuario = "";
		int inicio = sentenca.indexOf("(");
		int fim = sentenca.indexOf(")");
		usuario = sentenca.substring(inicio + 1, fim);
		return usuario;
	}

	@Override
	public boolean executeAction(String agName, Structure action) {
		int temperatura = 0;
		String iluminacao = "fraca";

		if (action.toString().contains("Temperatura")) {
			temperatura = extrairTemperatura(action.toString());
		}
		if (action.toString().contains("Iluminacao")) {
			iluminacao = extrairEstagioIluminacao(action.toString());
		}
		if (agName.equals("peca1_climatizacao") && action.getFunctor().contains("configurarTemperatura")) {
			System.out.println("[AMBIENTE FISICO] o arcondicionado, via relé de acionamento, representado por " + agName
					+ " vai configurar a temperatura em " + temperatura + " graus");
			quantidadeAcoesPeca1++;

			// acionar o rele desta peça
			//Comunicacao.Sonoff(endereco_arcondicionado, "on", temperatura, null);
		}
		if (agName.equals("peca2_climatizacao") && action.getFunctor().contains("configurarTemperatura")) {
			System.out.println("[AMBIENTE FISICO] o arcondicionado, via relé de acionamento, representado por " + agName
					+ " vai configurar a temperatura em " + temperatura + " graus");
			quantidadeAcoesPeca2++;

			// acionar o rele desta peça
			//Comunicacao.Sonoff(endereco_arcondicionado, "on", temperatura, null);
		}
		if (agName.equals("peca1_iluminacao") && action.getFunctor().contains("configurarIluminacao")) {
			System.out.println("[AMBIENTE FISICO] o sistema de iluminação, via relé de acionamento, representado por "
					+ agName + " está configurando a iluminacao como " + iluminacao);
			quantidadeAcoesPeca1++;

			// acionar o rele desta peça
			if (iluminacao.equals("forte")) {
				Comunicacao.Sonoff(endereco_iluminacao1, "on", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao2, "on", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao3, "off", 0, iluminacao);
			} else if (iluminacao.equals("media")) {
				Comunicacao.Sonoff(endereco_iluminacao1, "on", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao2, "off", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao3, "off", 0, iluminacao);
			}else if (iluminacao.equals("fraca")) {
				Comunicacao.Sonoff(endereco_iluminacao1, "off", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao2, "off", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao3, "on", 0, iluminacao);
			}
		}
		if (agName.equals("peca2_iluminacao") && action.getFunctor().contains("configurarIluminacao")) {
			System.out.println("[AMBIENTE FISICO] o sistema de iluminação, via relé de acionamento, representado por "
					+ agName + " está configurando a iluminacao como " + iluminacao);
			quantidadeAcoesPeca2++;

			// acionar o rele desta peça
			if (iluminacao.equals("forte")) {
				Comunicacao.Sonoff(endereco_iluminacao1, "on", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao2, "on", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao3, "off", 0, iluminacao);
			} else if (iluminacao.equals("media")) {
				Comunicacao.Sonoff(endereco_iluminacao1, "off", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao2, "on", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao3, "off", 0, iluminacao);
			}else if (iluminacao.equals("fraca")) {
				Comunicacao.Sonoff(endereco_iluminacao1, "off", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao2, "off", 0, iluminacao);
				Comunicacao.Sonoff(endereco_iluminacao3, "on", 0, iluminacao);
			}
		}
		if (quantidadeAcoesPeca1 == 2 || quantidadeAcoesPeca2 == 2) {
			quantidadeAcoesPeca1 = 0;
			quantidadeAcoesPeca2 = 0;
			try {
				Thread.sleep(4000);
				String usuario;
				Random gerador = new Random();
				switch (gerador.nextInt(2)) {
				case 0:
					// inserir um usuario numa peca
					usuario = sorteiaUsuarioNaMesmaPeca();
					if (!usuario.equals("erro")) {
						addPercept(ASSyntax.parseLiteral(usuario));
						// System.out.println("[AMBIENTE FISICO] um usuário vai entrar na peça");
					}
					break;
				case 1:
					// retirar um usuario de uma peca
					usuario = retiraUsuarioNaMesmaPeca();
					if (!usuario.equals("erro")) {
						removePercept(ASSyntax.parseLiteral(usuario));
						System.out.println("[AMBIENTE FISICO] o usuario " + extrairUsuario(usuario)
								+ " saiu da peca, mas suas configurações permaneceram....");		
					}
					break;
				}
			} catch (Exception e) {
			}
		}
		return true; // the action was executed with success
	}

	/** Called before the end of MAS execution */
	@Override
	public void stop() {
		super.stop();
	}

	class UsuarioPeca {
		public String usuario;
		public String peca;

		public UsuarioPeca(String usuario, String peca) {
			this.usuario = usuario;
			this.peca = peca;
		}
	}
}

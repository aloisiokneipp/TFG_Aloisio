package ambientePervasivo3;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class Comunicacao {
	public static void Sonoff(String query_url, String operador, int temperatura, String iluminacao) {		
		// String data = " { \"data\" : { \"switch\" : \"off\" } }";
		String data = " { \"data\" : { \"switch\" :  \"" + operador + "\" } }";
		try {
			URL url = new URL(query_url);
			HttpURLConnection conexao = (HttpURLConnection) url.openConnection();
			conexao.setConnectTimeout(100);
			conexao.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
			conexao.setDoOutput(true);
			conexao.setDoInput(true);
			conexao.setRequestMethod("POST");
			conexao.connect();
			OutputStream os = conexao.getOutputStream();
			os.write(data.getBytes("UTF-8"));
			os.close();
			conexao.getResponseMessage();
			conexao.disconnect();
			//System.out.println(conexao);
			//System.out.println("Finalizou.");
			//System.out.println(os);
			//System.out.println("concluiu");
		} catch (Exception e) {
			System.out.println("Erro de comunicacao.");
		}
	}
	
	
}

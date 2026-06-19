package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.Pokemon;

@WebServlet("/CercaProdottoServlet")
public class CercaProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CercaProdottoServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. Recupera la parola scritta dall'utente nel form (es. <input name="testoCercato">)
		String parolaCercata = request.getParameter("testoCercato");
		
		String formatoAjax = request.getParameter("ajax");
		
		// Creiamo la collezione usando il Model corretto
		java.util.Collection<model.Pokemon> risultati = new java.util.ArrayList<>();
		
		if (parolaCercata != null && !parolaCercata.trim().isEmpty()) {
			try {
				// 2. Chiamiamo il DAO che si occupa di tutta la connessione e della query!
				model.PokemonDAO dao = new model.PokemonDAO();
				risultati = dao.doRetrieveByNome(parolaCercata.trim());
				
			} catch (Exception e) {
				System.err.println("[CercaProdottoServlet] Errore durante la ricerca: " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		if ("true".equals(formatoAjax)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			
			StringBuilder json = new StringBuilder("[");
			
			// Trasformiamo la Collection in un array per gestire facilmente la virgola tra i Pokémon
			Pokemon[] arrayRisultati = risultati.toArray(new Pokemon[0]);
			
			for (int i = 0; i < arrayRisultati.length; i++) {
				Pokemon p = arrayRisultati[i];
				json.append("{")
					.append("\"id\":").append(p.getId()).append(",")
					.append("\"nome\":\"").append(p.getNome().replace("\"", "\\\"")).append("\",")
					.append("\"prezzo\":").append(p.getPrezzo())
					.append("}");
				
				// Aggiunge la virgola solo se NON è l'ultimo elemento dell'array
				if (i < arrayRisultati.length - 1) {
					json.append(",");
				}
			}
			json.append("]");
			
			response.getWriter().write(json.toString());
			return; 
		}
		
		// 3. Passa i risultati reali del DB alla pagina JSP
		// Nota: assicurati che il tuo collega legga l'attributo con questo nome esatto ("Risultatiricerca")
		request.setAttribute("Risultatiricerca", risultati);
		request.setAttribute("itemcercato", parolaCercata);
		
		request.getRequestDispatcher("/Risultatiricerca.jsp").forward(request, response);
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
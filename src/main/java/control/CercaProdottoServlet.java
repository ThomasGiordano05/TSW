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

@WebServlet("/CercaProdottoServlet")
public class CercaProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CercaProdottoServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. Recupera la parola scritta dall'utente nel form (es. <input name="testoCercato">)
		String parolaCercata = request.getParameter("testoCercato");
		
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
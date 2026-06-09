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
		// 1. Recupera la parola scritta dall'utente nel form
		String parolaCercata = request.getParameter("testoCercato");
		
		// Lista dove salveremo i Pokémon trovati nel DB
		java.util.ArrayList<model.Pokemon> risultati = new java.util.ArrayList<>();
		
		if (parolaCercata != null && !parolaCercata.trim().isEmpty()) {
			try {
				// 2. Si connette a MySQL usando la configurazione JNDI (web.xml / context.xml)
				Context initContext = new InitialContext();
				Context envContext  = (Context) initContext.lookup("java:comp/env");
				DataSource ds = (DataSource) envContext.lookup("jdbc/pokestoredb");
				Connection con = ds.getConnection();
				
				// 3. Prepara la Query SQL con il LIKE per trovare corrispondenze parziali
				String query = "SELECT * FROM Pokemon WHERE LOWER(nome) LIKE ?";
				PreparedStatement ps = con.prepareStatement(query);
				
				// Trasforma in minuscolo e aggiunge i % (es. %scintille%)
				ps.setString(1, "%" + parolaCercata.toLowerCase().trim() + "%");
				
				// 4. Esegue la query sul database
				ResultSet rs = ps.executeQuery();
				
				// 5. Trasforma le righe del DB in oggetti Java "Pokemon"
				while (rs.next()) {
					model.Pokemon p = new model.Pokemon();
					
					p.setId(rs.getInt("id"));
					
					// Mappa i dati (Assicurati che i metodi set nel tuo Model Pokemon si chiamino così)
					p.setNome(rs.getString("nome"));
					p.setTipo(rs.getString("tipo"));
					p.setPrezzo(rs.getDouble("prezzo"));
					p.setQuantita(rs.getInt("quantita"));
					
					risultati.add(p);
				}
				
				// Chiude le connessioni
				rs.close();
				ps.close();
				con.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 6. Passa i risultati reali del DB alla pagina JSP
		request.setAttribute("Risultatiricerca", risultati);
		request.setAttribute("itemcercato", parolaCercata);
		
		request.getRequestDispatcher("/Risultatiricerca.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
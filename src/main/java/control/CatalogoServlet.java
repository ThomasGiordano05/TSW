package control;

import java.io.IOException;   //import vari
import java.sql.SQLException;
import java.util.Collection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Pokemon;
import model.PokemonDAO;

@WebServlet("/CatalogoServlet")                      //mappatura per evitare web.xml
public class CatalogoServlet extends HttpServlet{

	private static final long serialVersionUID = 1L; //serializzazione per la compatibilità
	private PokemonDAO pokemonDao = new PokemonDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	           throws ServletException, IOException {
	    
	    try {
	        // 1. Il DAO interroga il Database
	        Collection<Pokemon> prodotti = pokemonDao.doRetrieveAll();
	        
	        // --- MODIFICA DA FARE: AGGIUNGI QUESTI DUE CONTROLLI DI DEBUG ---
	        System.out.println("--- DEBUG SERVLET ---");
	        System.out.println("La collezione prodotti è null? " + (prodotti == null));
	        if (prodotti != null) {
	            System.out.println("Quanti Pokémon ha trovato il DAO nel DB? " + prodotti.size());
	        }
	        // ---------------------------------------------------------------
	        
	        // 2. Li passo alla JSP
	        request.setAttribute("listaProdotti", prodotti);
	        
	        // 3. Faccio il forward alla pagina dello shop
	        RequestDispatcher dispatcher = request.getRequestDispatcher("Shop.jsp");
	        dispatcher.forward(request, response);
	        
	    } catch(SQLException e) {
	        e.printStackTrace(); 
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Impossibile caricare il catalogo.");
	    }
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {   //doPot con la chiamata della doGet
        doGet(request, response);
    }
}

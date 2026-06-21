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
		
		String categoria = request.getParameter("categoria"); 
	    String target = "Shop.jsp"; 
	    Collection<Pokemon> prodotti = null;
	    
	    try {
	        // 1. Il DAO interroga il Database
	    	if (categoria != null && !categoria.isEmpty()) {
	            // Se c'è una categoria, filtriamo
	            // ASSICURATI DI AVERE QUESTO METODO NEL DAO!
	            prodotti = pokemonDao.doRetrieveByTipo(categoria); 
	            
	            // Impostiamo il target corretto in base alla categoria
	            if ("carte".equalsIgnoreCase(categoria)) target = "Card.jsp";
	            else if ("box".equalsIgnoreCase(categoria)) target = "Box.jsp";
	            else if ("gadget".equalsIgnoreCase(categoria)) target = "Gadget.jsp";
	        } else {
	            // Se non c'è categoria, prendiamo tutto
	            prodotti = pokemonDao.doRetrieveAll();
	        }
	        
	        // 2. Passiamo i dati alla pagina scelta
	        request.setAttribute("listaProdotti", prodotti);
	        RequestDispatcher dispatcher = request.getRequestDispatcher(target);
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

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

@WebServlet("/DettaglioProdottoServlet")                      //mappatura per evitare web.xml
public class DettaglioProdottoServlet extends HttpServlet{

	private static final long serialVersionUID = 1L; //serializzazione per la compatibilità
	private PokemonDAO pokemonDao = new PokemonDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	           throws ServletException, IOException {
		
		String id =  request.getParameter("id"); 
	    String target = "DettaglioProdotto.jsp"; 
	    Pokemon prodotto = null;
	    
	    try {
	        //il DAO interroga il Database
	    	if (id != null && !id.isEmpty()) {
	            //se c'è un id, filtriamo
	    		
	    		int key = Integer.parseInt(id);
	            prodotto = pokemonDao.doRetrieveByKey(key); 
	            
	        }
	        
	        //passiamo i dati alla pagina scelta
	        request.setAttribute("prodotto", prodotto);
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

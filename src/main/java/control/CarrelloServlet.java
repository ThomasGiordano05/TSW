package control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Carrello;
import model.Pokemon;
import model.PokemonDAO;

@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PokemonDAO pokemonDao = new PokemonDAO();
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
             throws ServletException , IOException{
    	     
    	  HttpSession session = request.getSession();
    	  Carrello cart = (Carrello) session.getAttribute("carrello");
    	  
    	  if(cart == null) {
    		  cart = new Carrello();
    		  session.setAttribute("carrello", cart);
    	  }
    	  
    	  String action = request.getParameter("action");
    	  try {
    		  if("add".equals(action)) {
    			  int id = Integer.parseInt(request.getParameter("id"));
    			  Pokemon p = pokemonDao.doRetrieveByKey(id);
    			  if (p != null) {
                      cart.aggiungiprodotto(p , 1); // CORRETTO: Aggiunge
                  }
              } else if("remove".equals(action)) {
                  int id = Integer.parseInt(request.getParameter("id"));
                  Pokemon p = pokemonDao.doRetrieveByKey(id);
                  if (p != null) {
                      cart.rimuoviProdotto(p); // Gestione corretta della rimozione
                  }
              }}catch(SQLException e) {e.printStackTrace();}
    	  response.sendRedirect(request.getContextPath() + "/Carrello.jsp");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

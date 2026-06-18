package control;

import java.io.IOException;
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

@WebServlet("/CatalogoServlet")
public class CatalogoServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private PokemonDAO pokemonDao = new PokemonDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	           throws ServletException, IOException{
		
		try {
           Collection<Pokemon> prodotti = pokemonDao.doRetrieveAll();
            
            // 2. Li passo alla JSP
            request.setAttribute("listaProdotti", prodotti);
            
            // 3. Faccio il forward alla pagina dello shop
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Shop.jsp");
            dispatcher.forward(request, response);
            
		}catch(SQLException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath());
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

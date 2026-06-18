package control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UtenteDAO;

@WebServlet("/VerificaEmailServlet")
public class VerificaEmailServlet extends HttpServlet {
      private static final long serialVersionUID = 1L;
      
      private UtenteDAO utenteDao = new UtenteDAO();
      
      @Override
      protected void doGet(HttpServletRequest request , HttpServletResponse response)
                    throws ServletException , IOException {
    	  
    	  String email = request.getParameter("email");
    	  boolean esiste = false;
    	  
    	  if(email != null && !email.trim().isEmpty()) {
    		  try {
    			  esiste = utenteDao.checkEmailEsistente("email");
    		  }catch(SQLException e) {
    			  System.err.println("[PokeStore-ErroreAJAX] Errore verifica email: " + e.getMessage());
    		  }
    	  }
    	  
    	  response.setContentType("application/json");
    	  response.setCharacterEncoding("UTF-8");
     	  
    	  response.getWriter().print("{\"esiste\" : " + esiste + "}");
    	}  
    	  
       protected void doPost(HttpServletRequest request , HttpServletResponse response)
                     throws ServletException , IOException {
    	   doGet(request, response);
       
      }
      
}

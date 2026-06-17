package control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Utente;
import model.UtenteDAO;
import model.PasswordUtils;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Istanziamo il DAO per poter salvare i dati nel DB in seguito
    private UtenteDAO utenteDao = new UtenteDAO();

    // Usiamo doPost perché la registrazione invia dati sensibili (la password)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String passwordvalida = request.getParameter("password");
        
        if (email == null || passwordvalida == null || 
            email.trim().isEmpty() || passwordvalida.trim().isEmpty()) {
                
                // Se trovo campi vuoti, rimbalzo l'utente al form con un errore nell'URL
                response.sendRedirect("Login.jsp?errore=campivuoti");
                return; // Interrompe il metodo immediatamente
            }

            try {
                // 3. Applicazione della cifratura unidirezionale (SHA-256) sulla password
                String passwordHashata = PasswordUtils.hashPassword(passwordvalida);

                // 4. Creazione e popolamento dell'oggetto del Model (Bean Utente)
                Utente utenteLoggato = utenteDao.doRetrieveByLogin(email , passwordHashata);
                

                if(utenteLoggato != null) {
                	HttpSession session = request.getSession();
                	session.setAttribute("utente" , utenteLoggato);
                	session.setAttribute("messaggioConferma" , "Bentornato , " + utenteLoggato.getNome() + "!");
                    
                	if(utenteLoggato.getRuolo().equals("admin")) {
                		response.sendRedirect("PannelloAdmin.jsp");
                	}else {
                		response.sendRedirect("Index.jsp");
                	}
                	
                }else {
                	response.sendRedirect("Login.jsp?errore=invalidcreds");
                }
                
            } catch (SQLException e) {
                
                System.err.println("[PokeStore-Errore] Errore SQL : " + e.getMessage());
                
                response.sendRedirect("Login.jsp?errore=db");
            }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }
}
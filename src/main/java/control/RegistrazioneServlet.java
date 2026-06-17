package control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Utente;
import model.UtenteDAO;
import model.PasswordUtils;

@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Inizializziamo il DAO per i dati nel DB 
    private UtenteDAO UtenteDao = new UtenteDAO();

    // Usiamo doPost perché la registrazione (la password)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String passwordvalida = request.getParameter("password");
        
        if (nome == null || email == null || passwordvalida == null || 
                nome.trim().isEmpty() || email.trim().isEmpty() || passwordvalida.trim().isEmpty()) {
                
                // Se trovo campi vuoti,c'è un errore nell'URL
                response.sendRedirect("registrazione.jsp?errore=campivuoti");
                return; // Interrompe immediatamente
            }

            try {
                // 3. Applicazione della cifratura (SHA-256) sulla password
                String passwordHashata = PasswordUtils.hashPassword(passwordvalida);

                // 4. Creazione e popolamento dell'oggetto del Model (Bean Utente)
                Utente nuovoUtente = new Utente();
                nuovoUtente.setNome(nome);
                nuovoUtente.setCognome(cognome);
                nuovoUtente.setEmail(email);
                nuovoUtente.setPassword(passwordHashata); // Salviamo solo l'hash sicuro
                nuovoUtente.setRuolo("cliente"); // Ruolo di default per i nuovi iscritti

                // 5. Invocazione del DAO per i dati nel Database
                UtenteDao.doSave(nuovoUtente);

                // 6. Salvataggio del messaggio di successo nella sessione HTTP
                request.getSession().setAttribute("messaggioConferma", "Registrazione completata con successo! Ora puoi accedere.");
                
                // 7. Reindirizzamento alla pagina di Login (Pattern Post/Redirect/Get)
                response.sendRedirect("Login.jsp");

            } catch (SQLException e) {
                // Log dell'errore sulla console di Tomcat per monitoraggio dello sviluppatore
                System.err.println("[PokeStore-Errore] Errore nel salvataggio utente: " + e.getMessage());
                
                // Se l'email è già registrata (violazione del vincolo UNIQUE), intercettiamo l'errore
                response.sendRedirect("registrazione.jsp?errore=emailduplicata");
            }
    }

    // Se l'utente prova a digitare l'URL a mano va alla pagina del form di registrazione
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("Registrazione.jsp");
    }
}
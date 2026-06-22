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
    
    //inizializziamo il DAO per i dati nel DB 
    private UtenteDAO utenteDao = new UtenteDAO();

    //usiamo doPost perché la registrazione (la password)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nome = request.getParameter("name");
        String cognome = request.getParameter("surname");
        String email = request.getParameter("email");
        String passwordvalida = request.getParameter("password");
        
        if (nome == null || email == null || passwordvalida == null || 
                nome.trim().isEmpty() || email.trim().isEmpty() || passwordvalida.trim().isEmpty()) {
                
                //se trovo campi vuoti,c'è un errore nell'URL
                response.sendRedirect("Login.jsp?errore=campivuoti");
                return; //interrompe immediatamente
            }

            try {
                //applicazione della cifratura (SHA-256) sulla password
                String passwordHashata = PasswordUtils.hashPassword(passwordvalida);

                //creazione e popolamento dell'oggetto del Model (Bean Utente)
                Utente nuovoUtente = new Utente();
                nuovoUtente.setNome(nome);
                nuovoUtente.setCognome(cognome);
                nuovoUtente.setEmail(email);
                nuovoUtente.setPassword(passwordHashata); //salviamo solo l'hash sicuro
                nuovoUtente.setRuolo("cliente"); //ruolo di default per i nuovi iscritti

                nuovoUtente.setIdIndirizzo(1);
                //invocazione del DAO per i dati nel Database
                utenteDao.doSave(nuovoUtente);

                //salvataggio del messaggio di successo nella sessione HTTP
                request.getSession().setAttribute("messaggioConferma", "Registrazione completata con successo! Ora puoi accedere.");
                
                //reindirizzamento alla pagina di Login (Pattern Post/Redirect/Get)
                response.sendRedirect("Login.jsp");

            } catch (SQLException e) {
                //log dell'errore sulla console di Tomcat per monitoraggio dello sviluppatore
                System.err.println("[PokeStore-Errore] Errore nel salvataggio utente: " + e.getMessage());
                
                //se l'email è già registrata (violazione del vincolo UNIQUE), intercettiamo l'errore
                response.sendRedirect("Login.jsp?errore=emailduplicata");
            }
    }

    //se l'utente prova a digitare l'URL a mano va alla pagina del form di registrazione
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }
}
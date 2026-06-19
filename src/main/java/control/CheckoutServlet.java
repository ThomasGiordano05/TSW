package control;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        
        // 1. Se l'utente non è loggato, rimanda al login
        if (utente == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        //Recupera l'oggetto Carrello completo dalla sessione
        Carrello cartOggetto = (Carrello) session.getAttribute("carrello");
        
        // Verifica che l'oggetto esista e contenga articoli
        if (cartOggetto != null && cartOggetto.getArticoli() != null && !cartOggetto.getArticoli().isEmpty()) {
            
            // Inseriamo la Collection in un ArrayList per passarla in sicurezza al DAO
            ArrayList<ArticoloCarrello> carrello = new ArrayList<>(cartOggetto.getArticoli());
            
            double totale = 0;
            for (ArticoloCarrello art : carrello) {
                totale += art.getPokemon().getPrezzo() * art.getquantitaScelta();
            }

            // 2. Crea l'oggetto Ordine strutturato
            Ordine ordine = new Ordine();
            ordine.setTotale(totale);
            ordine.setIdUtente(utente.getId());           
            ordine.setIdIndirizzo(utente.getIdIndirizzo());      
            
            OrdineDAO ordineDAO = new OrdineDAO();
            boolean success = ordineDAO.doSave(ordine, carrello);

            if (success) {
                // Svuota il carrello reinserendo l'oggetto Carrello vuoto, non l'ArrayList!
                session.setAttribute("carrello", new Carrello());
                
                // Usiamo il redirect per evitare ordini duplicati al refresh della pagina
                session.setAttribute("messaggioSuccesso", "Ordine completato con successo!");
                response.sendRedirect("Index.jsp");
                return;
            }
        }
        
        // Se il carrello è vuoto o l'ordine fallisce, torna al carrello
        response.sendRedirect("Carrello.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
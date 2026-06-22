package control;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Carrello;
import model.Ordine;
import model.OrdineDAO;
import model.Utente;
import model.ArticoloCarrello;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrdineDAO ordineDao = new OrdineDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        Carrello cart = (Carrello) session.getAttribute("carrello");

        if (utente == null || cart == null || cart.getArticoli().isEmpty()) {
            response.sendRedirect("Carrello.jsp");
            return;
        }

        // 1. Recupero dei dati dal form a riga unica
        String indirizzoCompleto = request.getParameter("indirizzo"); 
        String citta = request.getParameter("citta");
        String cap = request.getParameter("cap");

        if (indirizzoCompleto == null || citta == null || cap == null || indirizzoCompleto.trim().isEmpty()) {
            response.sendRedirect("Checkout.jsp?error=campivuoti");
            return;
        }

        // 2. Separazione Intelligente di Via e Civico direttamente in Java
        String via = indirizzoCompleto.trim();
        String civico = "S.N."; // Valore di fallback se manca il civico

        if (indirizzoCompleto.contains(",")) {
            // Se l'utente scrive con la virgola (es. "Via Roma, 10") dividiamo lì
            String[] parti = indirizzoCompleto.split(",", 2);
            via = parti[0].trim();
            civico = parti[1].trim();
        } else {
            // Se scrive senza virgola (es. "Via Roma 10"), prendiamo l'ultimo blocco come civico
            int ultimoSpazio = indirizzoCompleto.lastIndexOf(" ");
            if (ultimoSpazio > 0) {
                via = indirizzoCompleto.substring(0, ultimoSpazio).trim();
                civico = indirizzoCompleto.substring(ultimoSpazio).trim();
            }
        }

        // 3. Creazione oggetto Ordine
        Ordine nuovoOrdine = new Ordine();
        nuovoOrdine.setIdUtente(utente.getId());
        nuovoOrdine.setTotale(cart.getTotale());

        ArrayList<ArticoloCarrello> elementiOrdine = new ArrayList<>(cart.getArticoli());
        
        // 4. Invio al DAO (i 6 parametri rimangono perfettamente supportati!)
        int idOrdineGenerato = ordineDao.doSave(nuovoOrdine, elementiOrdine, via, civico, cap, citta);

        if (idOrdineGenerato > 0) {
            cart.svuota();
            // WE CHANGED THIS: Redirect directly to the receipt, passing the new ID
            response.sendRedirect("Ricevuta.jsp?id=" + idOrdineGenerato);
        } else {
            response.sendRedirect("Checkout.jsp?error=transazione_fallita");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("Carrello.jsp");
    }
}
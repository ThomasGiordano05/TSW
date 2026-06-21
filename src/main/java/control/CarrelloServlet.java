package control;

import java.io.IOException;    //import vari
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

@WebServlet("/CarrelloServlet")                         //mappatura per evitare web.xml
public class CarrelloServlet extends HttpServlet {     
    private static final long serialVersionUID = 1L;   //serializzazione per la compatibilità
    private PokemonDAO pokemonDao = new PokemonDAO();
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Carrello cart = (Carrello) session.getAttribute("carrello");
        
        if(cart == null) {
            cart = new Carrello();
            session.setAttribute("carrello", cart);
        }
        
        String action = request.getParameter("action");
        try {
            // Aggiungi la gestione per PLUS e MINUS
            if ("add".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Pokemon p = pokemonDao.doRetrieveByKey(id);
                if (p != null) cart.aggiungiprodotto(p, 1);
                response.setStatus(HttpServletResponse.SC_OK);
                return;
            } 
            else if ("plus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                cart.aumentaQuantita(id); // ASSICURATI che questo metodo esista nel modello Carrello
                inviaJson(response, true, cart.getQuantita(id) , cart.getTotale());
                return;
            } 
            else if ("minus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                cart.diminuisciQuantita(id); // ASSICURATI che questo metodo esista nel modello Carrello
                inviaJson(response, true, cart.getQuantita(id) , cart.getTotale());
                return;
            }
            else if ("remove".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Pokemon p = pokemonDao.doRetrieveByKey(id);
                if (p != null) cart.rimuoviProdotto(p);
                inviaJson(response, true, 0, cart.getTotale());
                return;
            }
        } catch(SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);}
        }
    private void inviaJson(HttpServletResponse response, boolean success, int nuovaQuantita, double nuovoTotale) throws IOException {
        // 1. Reset totale del buffer per evitare scarti di altre parti del codice
        response.resetBuffer(); 
        
        // 2. Imposta i tipi correttamente
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // 3. Stringa JSON pulita
        String json = "{\"success\":" + success + ", \"nuovaQuantita\":" + nuovaQuantita + ", \"nuovoTotale\":" + nuovoTotale + "}";
        
        // 4. Scrivi e chiudi
        response.getWriter().print(json);
        response.getWriter().flush();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException { //doPot con la chiamata della doGet
        doGet(request, response);
    }
}

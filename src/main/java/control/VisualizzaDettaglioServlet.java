package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Pokemon;
import model.PokemonDAO;

@WebServlet("/VisualizzaDettaglioServlet")
public class VisualizzaDettaglioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                PokemonDAO dao = new PokemonDAO();
                
                Pokemon p = dao.doRetrieveByKey(id);
                
                if (p != null) {
                    request.setAttribute("prodotto", p);
                    request.getRequestDispatcher("/DettagliProdotto.jsp").forward(request, response);
                    return; 
                }
            } catch (SQLException | NumberFormatException e) {
                //catturiamo sia l'errore SQL sia eventuali id non numerici nell'URL
                e.printStackTrace();
            } 
        }
        
        //se l'id non esiste, non è valido o c'è stato un errore DB, finisci qui (UNICO punto di fallback)
        response.sendRedirect("Index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
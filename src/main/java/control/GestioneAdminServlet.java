package control;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Pokemon;
import model.PokemonDAO;
import model.Utente;

@WebServlet("/GestioneAdminServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 
                 maxFileSize = 1024 * 1024 * 10, 
                 maxRequestSize = 1024 * 1024 * 50)
public class GestioneAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PokemonDAO dao = new PokemonDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Utente adminUser = (Utente) request.getSession().getAttribute("utente");
        if (adminUser == null || !"AMMINISTRATORE".equalsIgnoreCase(adminUser.getRuolo())) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.doDelete(id); 
                response.sendRedirect("PannelloAdmin.jsp?success=1");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("PannelloAdmin.jsp?error=1");
            }
        }
    }

    //gestisce inserimento e modifica(Richieste tramite Form POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Utente adminUser = (Utente) request.getSession().getAttribute("utente");
        if (adminUser == null || !"AMMINISTRATORE".equalsIgnoreCase(adminUser.getRuolo())) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");

        //aggiungi prodotto
        if ("add".equals(action)) {
            try {
                String nome = request.getParameter("nome");
                String tipo = request.getParameter("tipo");
                String descrizione = request.getParameter("descrizione");
                double prezzo = Double.parseDouble(request.getParameter("prezzo"));
                int quantita = Integer.parseInt(request.getParameter("quantita"));
                int idCatalogo = Integer.parseInt(request.getParameter("idCatalogo"));

                Part filePart = request.getPart("immagine"); 
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
                
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                String dbImagePath = "images/" + fileName;

                Pokemon p = new Pokemon();
                p.setNome(nome);
                p.setTipo(tipo);
                p.setDescrizione(descrizione);
                p.setPrezzo(prezzo);
                p.setQuantita(quantita);
                p.setIdCatalogo(idCatalogo);
                p.setUrlImmagine(dbImagePath);

                dao.doSave(p);
                response.sendRedirect("PannelloAdmin.jsp?success=1");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("PannelloAdmin.jsp?error=1");
            }
        }
        
        // modifica prezzo e quantita
        else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                double nuovoPrezzo = Double.parseDouble(request.getParameter("prezzo"));
                int nuovaQuantita = Integer.parseInt(request.getParameter("quantita"));

                // recuperiamo il Pokémon esistente dal DB per non perdere gli altri dati (Nome, tipo, immagine...)
                Pokemon p = dao.doRetrieveByKey(id);
                if (p != null) {
                    p.setPrezzo(nuovoPrezzo);
                    p.setQuantita(nuovaQuantita);
                    
                    dao.doUpdate(p); // Esegue l'update corretto nel DB
                    response.sendRedirect("PannelloAdmin.jsp?success=1");
                } else {
                    response.sendRedirect("PannelloAdmin.jsp?error=1");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("PannelloAdmin.jsp?error=1");
            }
        }
    }
}
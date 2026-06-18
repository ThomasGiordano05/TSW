package control;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Utente;

@WebFilter("/admin/*")
public class FiltroAdmin extends HttpFilter implements Filter {
   private static final long serialversionUID = 1L;
   
   @Override
   public void doFilter(ServletRequest request , ServletResponse response , FilterChain chain)
   throws IOException , ServletException {
	   
	   HttpServletRequest httpRequest = (HttpServletRequest) request;
	   HttpServletResponse httpResponse = (HttpServletResponse) response;
	   
	   //Recuperiamo la sessione attuale
	   HttpSession session = httpRequest.getSession(false);
	   
	   boolean isAdmin = false;
	   
	   if(session != null) {
		   Utente utente = (Utente) session.getAttribute("utente");
		   //verifica se sei Admin
		   if(utente != null && "admin".equals(utente.getRuolo())){ 
			   isAdmin = true;
		   }
	   }
	   
	   if(isAdmin) {
		   chain.doFilter(request , response);
	   }else {
		   //lo sbattiamo via
		   httpResponse.sendRedirect(httpRequest.getContextPath() + "/Login.jsp?errore=accessonegato");
	   }
		   
		   
	   }
	   
	   @Override
	   public void init(FilterConfig fConfig) throws ServletException{}
	   
	   @Override 
	   public void destroy() {}
}

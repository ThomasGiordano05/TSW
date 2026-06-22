package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtenteDAO {

	public void doSave(Utente u)throws SQLException {
		String query = "INSERT INTO UTENTE(NOME, COGNOME, USERNAME, EMAIL, PASSWORD, TIPO_UTENTE, ID_INDIRIZZO) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try(Connection con = ConnessioneDB.getConnection();
			PreparedStatement ps = con.prepareStatement(query)){
			
			ps.setString(1, u.getNome());
            ps.setString(2, u.getCognome());
            ps.setString(3, u.getEmail().split("@")[0]); 
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPassword()); //sarà già hashata!
            if (u.getRuolo() != null) {
                ps.setString(6, u.getRuolo().toUpperCase());
            } else {
                ps.setString(6, "CLIENTE"); //default di sicurezza se ti dimentichi il setRuolo nella Servlet
            }
            ps.setObject(7, null); //inizialmente l'indirizzo è nullo, verrà aggiunto all'ordine
            
            ps.executeUpdate();
		}
	}
	
	public boolean checkEmailEsistente(String email) throws SQLException {
		String query = "SELECT ID_UTENTE FROM UTENTE WHERE EMAIL = ?";
		try (Connection con = ConnessioneDB.getConnection(); 
				PreparedStatement ps = con.prepareStatement(query)){
			
			ps.setString(1, email);
			try(ResultSet rs = ps.executeQuery()){
		return rs.next();
			}
	}
}
	
	public Utente doRetrieveByLogin(String email, String passwordHashata) throws SQLException {
	    
	    String query = "SELECT ID_UTENTE, NOME, COGNOME, EMAIL, TIPO_UTENTE, ID_INDIRIZZO FROM UTENTE WHERE EMAIL = ? AND PASSWORD = ?";
	    try(Connection con = ConnessioneDB.getConnection(); 
	            PreparedStatement ps = con.prepareStatement(query)){
	        
	        ps.setString(1, email);
	        ps.setString(2 , passwordHashata);
	        
	        try(ResultSet rs = ps.executeQuery()){
	            if(rs.next()) {
	                Utente u = new Utente();
	                u.setId(rs.getInt("ID_UTENTE"));
	                u.setNome(rs.getString("NOME"));
	                u.setCognome(rs.getString("COGNOME"));
	                u.setEmail(rs.getString("EMAIL"));
	                u.setRuolo(rs.getString("TIPO_UTENTE"));
	                
	              
	                u.setIdIndirizzo(rs.getInt("ID_INDIRIZZO")); 
	                
	                return u;
	            }
	        }
	    }
	    return null;
	}

}
package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtenteDAO {

	public void doSave(Utente u)throws SQLException {
		String query = "INSERT INTO utente(nome , cognome , email , password , ruolo) VALUES (? , ? , ? , ? , ?)";
		try(Connection con = ConnessioneDB.getConnection();
			PreparedStatement ps = con.prepareStatement(query)){
			
			ps.setString(1, u.getNome());
            ps.setString(2, u.getCognome());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword()); // Sarà già hashata!
            ps.setString(5, u.getRuolo()); // es. "cliente" di default
            
            ps.executeUpdate();
		}
	}
	
	public boolean checkEmailEsistente(String email) throws SQLException {
		String query = "SELECT id FROM utente WHERE email = ?";
		try (Connection con = ConnessioneDB.getConnection(); 
				PreparedStatement ps = con.prepareStatement(query)){
			
			ps.setString(1,  email);
			try(ResultSet rs = ps.executeQuery()){
		return rs.next();
			}
	}
}
	
	public Utente doRetrieveByLogin(String email, String passwordHashata) throws SQLException {
		String query = "SELECT id , nome , cognome , email , ruolo FROM utente WHERE email = ? AND password = ?";
		try(Connection con = ConnessioneDB.getConnection(); 
				PreparedStatement ps = con.prepareStatement(query)){
			
			ps.setString(1, email);
			ps.setString(2 , passwordHashata);
			
			try(ResultSet rs = ps.executeQuery()){
				if(rs.next()) {
					Utente u = new Utente();
					u.setId(rs.getInt("id"));
					u.setNome(rs.getString("nome"));
					u.setCognome(rs.getString("cognome"));
					u.setEmail(rs.getString("email"));
					u.setRuolo(rs.getString("ruolo"));
					return u;
					
					
				}
			}
			
		}
		return null;
	}

}
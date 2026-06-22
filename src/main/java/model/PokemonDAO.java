package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;


public class PokemonDAO {
     public Collection<Pokemon> doRetrieveAll() throws SQLException{
    	 String query = "SELECT ID, NOME, TIPO, DESCRIZIONE, PREZZO, QUANTITA, ID_CATALOGO, IMMAGINE FROM POKEMON WHERE ATTIVO = 1";
    	 
    	 Collection<Pokemon> listaProdotti = new ArrayList<>();
    	 
    	 try(Connection con = ConnessioneDB.getConnection();
    			 PreparedStatement ps = con.prepareStatement(query);
    			 ResultSet rs = ps.executeQuery()) {
    		 
    		 
    		 while(rs.next()) {
    			 Pokemon p = new Pokemon();
                 p.setId(rs.getInt("ID"));
                 p.setNome(rs.getString("NOME"));
                 p.setTipo(rs.getString("TIPO"));
                 p.setDescrizione(rs.getString("DESCRIZIONE"));
                 p.setPrezzo(rs.getDouble("PREZZO"));
                 p.setQuantita(rs.getInt("QUANTITA"));
    			 p.setUrlImmagine(rs.getString("IMMAGINE"));
    			 
    			 
    			 listaProdotti.add(p);
    	  }
    	 }
    		return listaProdotti;
     }
     public Collection<Pokemon> doRetrieveByNome(String nomeCercato) throws SQLException{
    	 String query = "SELECT ID, NOME, TIPO, DESCRIZIONE, PREZZO, QUANTITA, ID_CATALOGO, IMMAGINE FROM POKEMON WHERE NOME LIKE ? AND ATTIVO = 1";
    	 Collection<Pokemon> listaFiltrata = new ArrayList<>();
    	 try(Connection con = ConnessioneDB.getConnection();
    			 PreparedStatement ps = con.prepareStatement(query)){
    				 
    		 ps.setString(1, "%" + nomeCercato + "%");
    		 
    		 try (ResultSet rs = ps.executeQuery()){
    			 while(rs.next()) { 
    				 Pokemon p = new Pokemon();
                     p.setId(rs.getInt("ID"));
                     p.setNome(rs.getString("NOME"));
                     p.setTipo(rs.getString("TIPO"));
                     p.setDescrizione(rs.getString("DESCRIZIONE"));
                     p.setPrezzo(rs.getDouble("PREZZO"));
                     p.setQuantita(rs.getInt("QUANTITA"));
                     p.setUrlImmagine(rs.getString("IMMAGINE"));
                     
                     listaFiltrata.add(p);
    			 }
    		 }
    	 }
    	 return listaFiltrata;
    	 
    	 
     }
     public Pokemon doRetrieveByKey(int id) throws SQLException {
    	 String query = "SELECT ID, NOME, TIPO, DESCRIZIONE, PREZZO, QUANTITA, ID_CATALOGO, IMMAGINE FROM POKEMON WHERE ID = ?";
         
         try (Connection con = ConnessioneDB.getConnection();
              PreparedStatement ps = con.prepareStatement(query)) {
                  
             ps.setInt(1, id);
             
             try (ResultSet rs = ps.executeQuery()) {
                 if (rs.next()) { 
                     Pokemon p = new Pokemon();
                     p.setId(rs.getInt("ID"));
                     p.setNome(rs.getString("NOME"));
                     p.setTipo(rs.getString("TIPO"));
                     p.setDescrizione(rs.getString("DESCRIZIONE"));
                     p.setPrezzo(rs.getDouble("PREZZO"));
                     p.setQuantita(rs.getInt("QUANTITA"));
                     p.setUrlImmagine(rs.getString("IMMAGINE"));
                     
                     return p;
                 }
             }
         }
         return null;
     }
     
     public Collection<Pokemon> doRetrieveByCatalogo(int idCatalogo) throws SQLException {
    	    String query = "SELECT ID, NOME, TIPO, DESCRIZIONE, PREZZO, QUANTITA, ID_CATALOGO, IMMAGINE FROM POKEMON WHERE ID_CATALOGO = ? AND ATTIVO = 1";
    	    Collection<Pokemon> listaFiltrata = new ArrayList<>();
    	    
    	    try (Connection con = ConnessioneDB.getConnection();
    	         PreparedStatement ps = con.prepareStatement(query)) {
    	         
    	        ps.setInt(1, idCatalogo);
    	        
    	        try (ResultSet rs = ps.executeQuery()) {
    	            while (rs.next()) {
    	                Pokemon p = new Pokemon();
    	                p.setId(rs.getInt("ID"));
    	                p.setNome(rs.getString("NOME"));
    	                p.setTipo(rs.getString("TIPO"));
    	                p.setDescrizione(rs.getString("DESCRIZIONE"));
    	                p.setPrezzo(rs.getDouble("PREZZO"));
    	                p.setQuantita(rs.getInt("QUANTITA"));
    	                p.setUrlImmagine(rs.getString("IMMAGINE"));
    	                
    	                listaFiltrata.add(p);
    	            }
    	        }
    	    }
    	    return listaFiltrata;
    	}
     
     public Collection<Pokemon> doRetrieveByTipo(String tipo) throws SQLException {
    	    Connection connection = null;
    	    PreparedStatement preparedStatement = null;
    	    Collection<Pokemon> prodotti = new ArrayList<>();

    	    // La query filtra per tipo
    	    String selectSQL = "SELECT * FROM POKEMON WHERE TIPO = ?";

    	    try {
    	        connection = ConnessioneDB.getConnection();
    	        preparedStatement = connection.prepareStatement(selectSQL);
    	        preparedStatement.setString(1, tipo); // Inserisce il tipo (es: "box") al posto del ?

    	        ResultSet rs = preparedStatement.executeQuery();

    	        while (rs.next()) {
    	            Pokemon p = new Pokemon();
    	            p.setId(rs.getInt("ID"));
    	            p.setNome(rs.getString("NOME"));
    	            p.setTipo(rs.getString("TIPO"));
    	            p.setPrezzo(rs.getDouble("PREZZO"));
    	            p.setDescrizione(rs.getString("DESCRIZIONE"));
    	            p.setUrlImmagine(rs.getString("IMMAGINE"));
    	            p.setQuantita(rs.getInt("QUANTITA"));
    	            p.setIdCatalogo(rs.getInt("ID_CATALOGO"));
    	            prodotti.add(p);
    	        }
    	    } finally {
    	        if (preparedStatement != null) preparedStatement.close();
    	        if (connection != null) connection.close();
    	    }
    	    return prodotti;
    	}
     
  // 1. INSERIMENTO NUOVO PRODOTTO
     public void doSave(Pokemon p) throws SQLException {
         String query = "INSERT INTO POKEMON (NOME, TIPO, DESCRIZIONE, PREZZO, QUANTITA, IMMAGINE , ID_CATALOGO , ATTIVO) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
         
         try (Connection con = ConnessioneDB.getConnection();
              PreparedStatement ps = con.prepareStatement(query)) {
              
             ps.setString(1, p.getNome());
             ps.setString(2, p.getTipo());
             ps.setString(3, p.getDescrizione());
             ps.setDouble(4, p.getPrezzo());
             ps.setInt(5, p.getQuantita());
             ps.setString(6, p.getUrlImmagine());
             ps.setInt(7, p.getIdCatalogo());
             ps.setInt(8, 1);
             
             ps.executeUpdate();
         }
     }

     // 2. MODIFICA PRODOTTO ESISTENTE
  // MODIFICA PRODOTTO ESISTENTE (Versione Corretta)
     public void doUpdate(Pokemon p) throws SQLException {
         String query = "UPDATE POKEMON SET NOME = ?, TIPO = ?, DESCRIZIONE = ?, PREZZO = ?, QUANTITA = ?, IMMAGINE = ? WHERE ID = ?";
         
         try (Connection con = ConnessioneDB.getConnection();
              PreparedStatement ps = con.prepareStatement(query)) {
              
             ps.setString(1, p.getNome());
             ps.setString(2, p.getTipo());
             ps.setString(3, p.getDescrizione());
             ps.setDouble(4, p.getPrezzo());
             ps.setInt(5, p.getQuantita());
             ps.setString(6, p.getUrlImmagine());
             ps.setInt(7, p.getId()); // L'ID va al posto del 7° punto interrogativo!
            
             ps.executeUpdate();
         }
     }

     // 3. CANCELLAZIONE PRODOTTO
     public void doDelete(int id) throws SQLException {
    	    // Invece di DELETE, impostiamo una colonna ATTIVO a 0
    	    String query = "UPDATE POKEMON SET ATTIVO = 0 WHERE ID = ?";
    	    
    	    try (Connection con = ConnessioneDB.getConnection();
    	         PreparedStatement ps = con.prepareStatement(query)) {
    	         
    	        ps.setInt(1, id);
    	        ps.executeUpdate();
    	    }
    	}
}

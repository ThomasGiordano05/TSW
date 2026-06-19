package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;


public class PokemonDAO {
     public Collection<Pokemon> doRetrieveAll() throws SQLException{
    	 String query = "SELECT ID, NOME, TIPO, PREZZO, QUANTITA, ID_CATALOGO , IMMAGINE FROM POKEMON ";
    	 
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
    	 String query = "SELECT ID, NOME, TIPO, PREZZO, QUANTITA, ID_CATALOGO, IMMAGINE FROM POKEMON WHERE NOME LIKE ?";
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
         String query = "SELECT ID, NOME, TIPO, PREZZO, QUANTITA, ID_CATALOGO, IMMAGINE FROM POKEMON WHERE ID = ?";
         
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
     
     
}

package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;


public class PokemonDAO {
     public Collection<Pokemon> doRetrieveAll() throws SQLException{
    	 String query = "SELECT * FROM pokemon";
    	 
    	 Collection<Pokemon> listaProdotti = new ArrayList<>();
    	 
    	 try(Connection con = ConnessioneDB.getConnection();
    			 PreparedStatement ps = con.prepareStatement(query);
    			 ResultSet rs = ps.executeQuery()) {
    		 
    		 while(rs.next()) {
    			 Pokemon p = new Pokemon();
    			 
    			 p.setId(rs.getInt("id"));
    			 p.setNome(rs.getString("Nome"));
    			 p.setTipo(rs.getString("Tipo"));
    			 p.setPrezzo(rs.getInt("prezzo"));
    			 p.setQuantita(rs.getInt("Quantita"));
    			 p.setUrlImmagine(rs.getString("Immagine"));
    			 
    			 
    			 listaProdotti.add(p);
    	  }
    	 }
    		return listaProdotti;
     }
     public Pokemon doRetrieveByKey(int id) throws SQLException{
    	 String query = "SELECT * FROM pokemon WHERE id = ?";
    	 
    	 try(Connection con = ConnessioneDB.getConnection();
    			 PreparedStatement ps = con.prepareStatement(query)){
    				 
    		 ps.setInt(1, id);
    		 
    		 try (ResultSet rs = ps.executeQuery()){
    			 if(rs.next()) {
    				 Pokemon p = new Pokemon();
                     
                     p.setId(rs.getInt("id"));
                     p.setNome(rs.getString("nome"));
                     p.setTipo(rs.getString("tipo"));
                     p.setPrezzo(rs.getDouble("prezzo"));
                     p.setQuantita(rs.getInt("quantita"));
                     p.setUrlImmagine(rs.getString("immagine"));
                     
                     return p;
    			 }
    		 }
    	 }
    	 return null;
     }
}

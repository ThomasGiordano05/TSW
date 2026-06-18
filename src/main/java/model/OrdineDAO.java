package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class OrdineDAO {

    // Salva l'ordine e le sue righe dentro una TRANSAZIONE sicura
    public boolean doSave(Ordine ordine, ArrayList<ArticoloCarrello> elementi) {
        String queryOrdine = "INSERT INTO ORDINE (TOTALE, ID_UTENTE, ID_INDIRIZZO) VALUES (?, ?, ?)";
        String queryRiga = "INSERT INTO RIGA_ORDINE (QUANTITA, PREZZO_UNITARIO, ID_ORDINE, ID_POKEMON) VALUES (?, ?, ?, ?)";
        
        Connection con = null;
        try {
            con = ConnessioneDB.getConnection();
            con.setAutoCommit(false); // Avvia la transazione d'esame
            
            // 1. Salva la testa dell'ordine
            try (PreparedStatement psO = con.prepareStatement(queryOrdine, Statement.RETURN_GENERATED_KEYS)) {
                psO.setDouble(1, ordine.getTotale());
                psO.setInt(2, ordine.getIdUtente());
                psO.setInt(3, ordine.getIdIndirizzo());
                psO.executeUpdate();
                
                ResultSet rs = psO.getGeneratedKeys();
                if (rs.next()) {
                    int idOrdineGenerato = rs.getInt(1);
                    
                    // 2. Salva tutte le righe associate attingendo dal carrello
                    try (PreparedStatement psR = con.prepareStatement(queryRiga)) {
                        for (ArticoloCarrello art : elementi) {
                            psR.setInt(1, art.getquantitaScelta());
                            psR.setDouble(2, art.getPokemon().getPrezzo());
                            psR.setInt(3, idOrdineGenerato);
                            psR.setInt(4, art.getPokemon().getId());
                            psR.addBatch();
                        }
                        psR.executeBatch();
                    }
                }
            }
            
            con.commit(); // Salva tutto definitivamente
            return true;
        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
        } finally {
            if (con != null) {
                try { con.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
        return false;
    }
}
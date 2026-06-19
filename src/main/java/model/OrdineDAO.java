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
    public ArrayList<Ordine> doRetrieveByDate(java.sql.Date dataInizio, java.sql.Date dataFine) {
        ArrayList<Ordine> lista = new ArrayList<>();
        // Nota: Assicurati che "DATA_ORDINE" sia il nome esatto della colonna nel tuo DB
        String query = "SELECT * FROM ORDINE WHERE DATA_ORDINE BETWEEN ? AND ?"; 
        
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setDate(1, dataInizio);
            ps.setDate(2, dataFine);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine o = new Ordine();
                    // Assicurati che i setter e i nomi delle colonne corrispondano al tuo database
                    o.setIdOrdine(rs.getInt("ID_ORDINE"));
                    o.setTotale(rs.getDouble("TOTALE"));
                    o.setIdUtente(rs.getInt("ID_UTENTE"));
                    o.setIdIndirizzo(rs.getInt("ID_INDIRIZZO"));
                    lista.add(o);
                }
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return lista;
    }

    // 2. FILTRO ORDINI PER CLIENTE (Usa PreparedStatement contro SQL Injection)
    public ArrayList<Ordine> doRetrieveByCliente(int idUtente) {
        ArrayList<Ordine> lista = new ArrayList<>();
        String query = "SELECT * FROM ORDINE WHERE ID_UTENTE = ?";
        
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, idUtente);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine o = new Ordine();
                    o.setIdOrdine(rs.getInt("ID_ORDINE"));
                    o.setTotale(rs.getDouble("TOTALE"));
                    o.setIdUtente(rs.getInt("ID_UTENTE"));
                    o.setIdIndirizzo(rs.getInt("ID_INDIRIZZO"));
                    lista.add(o);
                }
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return lista;
    }
}
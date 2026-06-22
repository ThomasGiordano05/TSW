package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class OrdineDAO {

    //salva l'ordine e le sue righe dentro una TRANSAZIONE sicura
	public int doSave(Ordine ordine, ArrayList<ArticoloCarrello> elementi, String via, String civico, String cap, String citta) {
	    String queryIndirizzo = "INSERT INTO INDIRIZZO (VIA, CAP, CIVICO, CITTA, NAZIONE) VALUES (?, ?, ?, ?, 'Italia')";
	    String queryOrdine = "INSERT INTO ORDINE (TOTALE, ID_UTENTE, ID_INDIRIZZO) VALUES (?, ?, ?)";
	    String queryRiga = "INSERT INTO RIGA_ORDINE (QUANTITA, PREZZO_UNITARIO, ID_ORDINE, ID_POKEMON) VALUES (?, ?, ?, ?)";
	     
	    Connection con = null;
	    try {
	        con = model.ConnessioneDB.getConnection(); 
	        con.setAutoCommit(false); // Disattiviamo l'autocommit per gestire la transazione
	        
	        //salva l'indirizzo scritto nel Form ---
	        int idIndirizzoGenerato = -1;
	        try (PreparedStatement psI = con.prepareStatement(queryIndirizzo, java.sql.Statement.RETURN_GENERATED_KEYS)) {
	            psI.setString(1, via);
	            psI.setString(2, cap);
	            psI.setString(3, civico);
	            psI.setString(4, citta);
	            psI.executeUpdate();
	            
	            //recuperiamo l'ID appena creato da MySQL per questa riga
	            try (ResultSet rsI = psI.getGeneratedKeys()) {
	                if (rsI.next()) {
	                    idIndirizzoGenerato = rsI.getInt(1);
	                }
	            }
	        }

	        //se non siamo riusciti a ottenere l'ID dell'indirizzo, blocchiamo tutto
	        if (idIndirizzoGenerato == -1) {
	            throw new java.sql.SQLException("Impossibile generare l'ID per l'indirizzo.");
	        }
	        
	        //salva la testa dell'Ordine collegandola all'indirizzo sopra ---
	        int idOrdineGenerato = -1;
	        try (PreparedStatement psO = con.prepareStatement(queryOrdine, java.sql.Statement.RETURN_GENERATED_KEYS)) {
	            psO.setDouble(1, ordine.getTotale());
	            psO.setInt(2, ordine.getIdUtente());
	            psO.setInt(3, idIndirizzoGenerato);
	            psO.executeUpdate();
	            
	            //recuperiamo l'ID di questo specifico ordine appena nato
	            try (ResultSet rsO = psO.getGeneratedKeys()) {
	                if (rsO.next()) {
	                    idOrdineGenerato = rsO.getInt(1);
	                }
	            }
	        }
	        
	        if (idOrdineGenerato == -1) {
	            throw new java.sql.SQLException("Impossibile generare l'ID per l'ordine.");
	        }
	        
	        //alva tutte le righe del carrello nel dettaglio ordine
	        try (PreparedStatement psR = con.prepareStatement(queryRiga)) {
	            for (ArticoloCarrello art : elementi) {
	                psR.setInt(1, art.getquantitaScelta());
	                psR.setDouble(2, art.getPokemon().getPrezzo());
	                psR.setInt(3, idOrdineGenerato);
	                psR.setInt(4, art.getPokemon().getId());
	                psR.addBatch();
	            }
	            psR.executeBatch(); //esegue tutto in un colpo solo
	        }
	        
	        con.commit(); 
	        return idOrdineGenerato;
	        
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
	    return -1;
	}
    public ArrayList<Ordine> doRetrieveByDate(java.sql.Date dataInizio, java.sql.Date dataFine) {
        ArrayList<Ordine> lista = new ArrayList<>();
        String query = "SELECT * FROM ORDINE WHERE DATA_ORDINE BETWEEN ? AND ?"; 
        
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setDate(1, dataInizio);
            ps.setDate(2, dataFine);
            
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

    //filtro ordini per cliente
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
    
    //visualizzazione di tutti gli ordini
    public ArrayList<Ordine> doRetrieveAll() {
        ArrayList<Ordine> lista = new ArrayList<>();
        String query = "SELECT * FROM ORDINE";
        
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Ordine o = new Ordine();
                o.setIdOrdine(rs.getInt("ID_ORDINE"));
                o.setTotale(rs.getDouble("TOTALE"));
                o.setIdUtente(rs.getInt("ID_UTENTE"));
                o.setIdIndirizzo(rs.getInt("ID_INDIRIZZO"));
                lista.add(o);
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return lista;
    }

    // METODI AGGIUNTI PER FAR FUNZIONARE LA RICEVUTA
    
    
    //recupera ordine dall'id
    public Ordine doRetrieveById(int idOrdine) {
        String query = "SELECT * FROM ORDINE WHERE ID_ORDINE = ?";
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Ordine o = new Ordine();
                    o.setIdOrdine(rs.getInt("ID_ORDINE"));
                    o.setTotale(rs.getDouble("TOTALE"));
                    o.setIdUtente(rs.getInt("ID_UTENTE"));
                    o.setIdIndirizzo(rs.getInt("ID_INDIRIZZO"));
                    return o;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<ArticoloCarrello> getProdottiOrdine(int idOrdine) {
        ArrayList<ArticoloCarrello> lista = new ArrayList<>();
        
        String query = "SELECT r.QUANTITA, r.PREZZO_UNITARIO, r.ID_POKEMON, p.NOME " +
                "FROM RIGA_ORDINE r " +
                "LEFT JOIN POKEMON p ON r.ID_POKEMON = p.ID " +
                "WHERE r.ID_ORDINE = ?";
        
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ArticoloCarrello art = new ArticoloCarrello();
                    art.setquantitaScelta(rs.getInt("QUANTITA"));
                    
                    Pokemon p = new Pokemon();
                    p.setId(rs.getInt("ID_POKEMON"));
                    
                    //se il nome è NULL (perché il Prodotto non esiste più), diamo un nome di default
                    String nome = rs.getString("NOME");
                    p.setNome(nome != null ? nome : "Pokémon non più disponibile");
                    
                    p.setPrezzo(rs.getDouble("PREZZO_UNITARIO"));
                    
                    art.setPokemon(p);
                    lista.add(art);
                }
            }
        } catch (Exception e) {
        	System.err.println("ERRORE CRITICO in getProdottiOrdine: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
}
package model;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnessioneDB {
    // Il DataSource rappresenta il nostro Connection Pool gestito da Tomcat
    private static DataSource ds = null;

    // Il blocco static viene eseguito una sola volta in assoluto quando la classe viene caricata in memoria
    static {
        try {
            System.out.println("[PokeStore-BackEnd] Inizializzazione JNDI Lookup...");
            
            // InitialContext ci permette di accedere all'albero delle risorse di Tomcat
            InitialContext ctx = new InitialContext();
            
            // "java:comp/env/" è la cartella standard di Tomcat in cui risiedono le risorse della webapp.
            // Ci attacchiamo il nome del pool configurato nel tuo web.xml: "jdbc/PokeStoreDB"
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/pokestoredb");
            
            System.out.println("Connection Pool (DataSource) caricato con SUCCESSO!");
        } catch (NamingException e) {
            System.err.println("ERRORE CRITICO: Impossibile trovare la risorsa JNDI!");
            e.printStackTrace();
        }
    }

    // Metodo pubblico e statico che chiameremo in TUTTI i DAO per ottenere una connessione
    public static Connection getConnection() throws SQLException {
        if (ds == null) {
            throw new SQLException("Il DataSource non è stato inizializzato. Controlla context.xml e web.xml.");
        }
        
        
        Connection connessione = ds.getConnection();
        System.out.println("Connessione prelevata dal pool con successo.");
        return connessione;
    }
}
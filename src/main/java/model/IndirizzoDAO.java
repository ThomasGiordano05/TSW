package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class IndirizzoDAO {

    public int doSave(Indirizzo ind) {
        String query = "INSERT INTO INDIRIZZO (VIA, CAP, CIVICO, CITTA, NAZIONE) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConnessioneDB.getConnection();
             PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, ind.getVia());
            ps.setString(2, ind.getCap());
            ps.setString(3, ind.getCivico());
            ps.setString(4, ind.getCitta());
            ps.setString(5, ind.getNazione());
            
            ps.executeUpdate();
            
            // Recupera l'ID autoincrementale appena generato dal DB
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
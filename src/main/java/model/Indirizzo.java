package model;

public class Indirizzo {
    private int idIndirizzo;
    private String via;
    private String cap;
    private String civico;
    private String citta;
    private String nazione;

    public Indirizzo() {}

    public int getIdIndirizzo() { return idIndirizzo; }
    public void setIdIndirizzo(int idIndirizzo) { this.idIndirizzo = idIndirizzo; }

    public String getVia() { return via; }
    public void setVia(String via) { this.via = via; }

    public String getCap() { return cap; }
    public void setCap(String cap) { this.cap = cap; }

    public String getCivico() { return civico; }
    public void setCivico(String civico) { this.civico = civico; }

    public String getCitta() { return citta; }
    public void setCitta(String citta) { this.citta = citta; }

    public String getNazione() { return nazione; }
    public void setNazione(String nazione) { this.nazione = nazione; }
}
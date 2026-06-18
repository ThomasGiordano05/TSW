package model;

import java.util.Date;

public class Ordine {
    private int idOrdine;
    private double totale;
    private int idUtente;
    private int idIndirizzo;

    public Ordine() {}

    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

    public double getTotale() { return totale; }
    public void setTotale(double totale) { this.totale = totale; }

    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

    public int getIdIndirizzo() { return idIndirizzo; }
    public void setIdIndirizzo(int idIndirizzo) { this.idIndirizzo = idIndirizzo; }
}
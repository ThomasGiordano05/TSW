package model;

import java.io.Serializable;

// Implementare Serializable serve a Java per poter "salvare" o trasferire questo oggetto sul server
public class Pokemon implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String nome;
    private String tipo;
    private double prezzo;
    private String urlImmagine; 
    private int quantita;

    public Pokemon(){}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }

    public String getUrlImmagine() { return urlImmagine; }
    public void setUrlImmagine(String urlImmagine) { this.urlImmagine = urlImmagine; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }
}
package model;

import java.io.Serializable;

//implementare Serializable serve a Java per poter "salvare" o trasferire questo oggetto sul server
public class Pokemon implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String nome;
    private String tipo;
    private double prezzo;
    private String urlImmagine; 
    private int quantita;
    private String descrizione;
    private int idCatalogo;

    public Pokemon(){}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    
    public String getDescrizione(){ return descrizione; }
    public void setDescrizione(String descrizione) {this.descrizione = descrizione;}

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }

    public String getUrlImmagine() { return urlImmagine; }
    public void setUrlImmagine(String urlImmagine) { this.urlImmagine = urlImmagine; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita;}
    public int getIdCatalogo() {	return idCatalogo;}
	public void setIdCatalogo(int idCatalogo) {this.idCatalogo = idCatalogo;}
    @Override  //per evitare che id uguali creino elementi diversi
    public boolean equals(Object obj) {
    	if(this == obj) {
    		return true;
    	}
    	if(obj == null || getClass() != obj.getClass()) {
    		return false;
    	}
    	Pokemon other = (Pokemon) obj;
    	return this.id == other.id;		
    }
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + id;
        return result;
    }
    
    public String toString() {
    	return "Prodotto [" + id + ", nome : " + nome + ", tipo : " + tipo + ", prezzo : " + prezzo + ", quantitaMagazzino : " + quantita + "]";
    }

	
}
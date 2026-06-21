package model;
import java.io.Serializable;

public class ArticoloCarrello {
     private static final long serialVersionUID= 1L;
     
     private Pokemon pokemon;
     private int quantitaScelta;
     
     public ArticoloCarrello() {
    	   
    	}
     
     public ArticoloCarrello(Pokemon pokemon , int quantitaScelta) {
    	 this.pokemon = pokemon;
    	 this.quantitaScelta = quantitaScelta;
     }
     
     public Pokemon getPokemon() { return pokemon ; }
     public void setPokemon(Pokemon pokemon) { this.pokemon = pokemon;}
     
     public int getquantitaScelta() { return quantitaScelta; }
     public void setquantitaScelta(int quantitaScelta) {this.quantitaScelta = quantitaScelta;}
     
     public double getPrezzoUnitario() {
         return this.pokemon.getPrezzo(); 
     }
     public double getPrezzoTotaleArticolo() {
    	 return this.pokemon.getPrezzo() * this.quantitaScelta ;
     }
     
}

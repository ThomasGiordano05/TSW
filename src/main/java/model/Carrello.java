package model;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Carrello implements Serializable{
	private static final long serialVersionUID = 1L;
    
	
	private List<ArticoloCarrello> articoli;
	
	public Carrello() {
		this.articoli = new ArrayList<>();
	}
	public List<ArticoloCarrello> getArticoli(){
		return articoli;
	}
	
	public void aggiungiprodotto(Pokemon p ,int quantita) {
		for (ArticoloCarrello art : articoli) {
			if(art.getPokemon().equals(p)) {
				art.setquantitaScelta(art.getquantitaScelta() + quantita);
				return;
			}
		}
		articoli.add(new ArticoloCarrello(p , quantita)); 
	}
	
	public void rimuoviProdotto(Pokemon p) {
		for(int i = 0 ; i < articoli.size() ; i++) {
			if(articoli.get(i).getPokemon().equals(p)) {
				articoli.remove(i);
				break;
			}
		}
	
	}
	
	public void modificaQuantita(Pokemon p , int newQuantita) {
		if(newQuantita <= 0) {
			rimuoviProdotto(p);
		}
		for(ArticoloCarrello art : articoli) {
			if(art.getPokemon().equals(p)) {
			art.setquantitaScelta(newQuantita);
			break;
				}
			}	
		}
	
	public double getTotale() {
		double totale = 0;
		for(ArticoloCarrello art : articoli) {
			totale += art.getPrezzoTotaleArticolo();
			}
		return totale;
		}
		
	public void svuota() {
        articoli.clear();
	}
}

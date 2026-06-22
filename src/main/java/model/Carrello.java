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
	
	//Metodi per la gestione AJAX

    public void aumentaQuantita(int id) {
        for (ArticoloCarrello art : articoli) {
            if (art.getPokemon().getId() == id) {
                art.setquantitaScelta(art.getquantitaScelta() + 1);
                break;
            }
        }
    }

    public void diminuisciQuantita(int id) {
        for (int i = 0; i < articoli.size(); i++) {
            ArticoloCarrello art = articoli.get(i);
            if (art.getPokemon().getId() == id) {
                if (art.getquantitaScelta() > 1) {
                    art.setquantitaScelta(art.getquantitaScelta() - 1);
                } else {
                    articoli.remove(i);//se 1 viene rimosso
                }
                break;
            }
        }
    }

    public int getQuantita(int id) {
        for (ArticoloCarrello art : articoli) {
            if (art.getPokemon().getId() == id) {
                return art.getquantitaScelta();
            }
        }
        return 0; //se non trova
    }
		
	public void svuota() {
        articoli.clear();
	}
}

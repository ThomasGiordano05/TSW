package model;

public class RigaOrdine {
    private int idRiga;
    private int quantita;
    private double prezzoUnitario;
    private int idOrdine;
    private int idPokemon;

    public RigaOrdine() {}

    public int getIdRiga() { return idRiga; }
    public void setIdRiga(int idRiga) { this.idRiga = idRiga; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    public double getPrezzoUnitario() { return prezzoUnitario; }
    public void setPrezzoUnitario(double prezzoUnitario) { this.prezzoUnitario = prezzoUnitario; }

    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

    public int getIdPokemon() { return idPokemon; }
    public void setIdPokemon(int idPokemon) { this.idPokemon = idPokemon; }
}
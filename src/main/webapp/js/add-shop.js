document.addEventListener("DOMContentLoaded", () => {
    // Nota: verifica che '.confirm-button' sia la classe corretta del tuo bottone
    const btn = document.querySelectorAll(".confirm-button");

   btn.forEach(btn => { // Controllo di sicurezza: se il bottone non c'è, non crasha lo script
        btn.addEventListener("click", (e) => {
            // Se il bottone è dentro un form, impediamo il ricaricamento pagina classico
            e.preventDefault(); 
            
            // Supponendo che tu abbia un modo per recuperare l'ID (es. un attributo data-id)
            const idPokemon = btn.getAttribute("data-id"); 

            fetch('CarrelloServlet?action=add&id=' + idPokemon, {
                method: 'POST'
            })
            .then(response => {
                if (response.ok) {
                    alert("Prodotto aggiunto al carrello!");
                } else {
                    alert("Errore durante l'aggiunta al carrello.");
                }
            })
            .catch(error => console.error('Errore:', error));
        });
    });
});
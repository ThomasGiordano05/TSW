document.addEventListener("DOMContentLoaded", () => {
    // Selezioniamo il bottone tramite la classe 'cart_shop'
    const cartButtons = document.querySelectorAll(".cart_shop");

    cartButtons.forEach(btn => {
        btn.addEventListener("click", (e) => {
            e.preventDefault(); 
            
            // Qui preleva il data-id che hai messo nel link HTML
            const idPokemon = btn.getAttribute("data-id");

            if (!idPokemon) return;

            // Invia al server
            fetch('CarrelloServlet?action=add&id=' + idPokemon, {
                method: 'POST'
            })
            .then(response => {
                if (response.ok) {
                    alert("Prodotto aggiunto al carrello!");
                } else {
                    alert("Errore durante l'aggiunta.");
                }
            })
            .catch(error => console.error('Errore:', error));
        });
    });
});
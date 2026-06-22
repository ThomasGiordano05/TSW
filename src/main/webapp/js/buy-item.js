document.addEventListener("DOMContentLoaded", () => {
    // Usiamo querySelectorAll per prendere TUTTI i bottoni dello shop
    const bottoniAcquista = document.querySelectorAll(".cart_shop");

    bottoniAcquista.forEach(btn => {
        btn.addEventListener("click", function() {
            // Recuperiamo l'ID dal data-id (assicurati che sia presente nell'HTML)
            const idPokemon = this.getAttribute("data-id");

            // Chiamiamo la logica di aggiunta (quella che abbiamo visto prima)
            // Se non hai già una funzione addToCart, chiamiamo la Servlet direttamente
            fetch('CarrelloServlet?action=add&id=' + idPokemon, {
                method: 'POST'
            })
            .then(response => {
                // Ora che l'aggiunta è fatta, mostriamo il popup
                document.querySelector(".all-shadow").style.display = "block";
                document.querySelector(".container-shop").style.display = "block";
            })
        });
    });
});
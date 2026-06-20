document.addEventListener("DOMContentLoaded", () => {
    const btn = document.querySelector(".button-checkout");

    if (btn) {
        btn.addEventListener("click", () => {
            // Eseguiamo una chiamata alla servlet di checkout
            fetch('CheckoutServlet', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Ordine effettuato con successo! Grazie per aver scelto PokéCave.");
                    // Reindirizziamo l'utente alla pagina di ringraziamento o home
                    window.location.href = "Index.jsp";
                } else {
                    alert("Errore durante il checkout: " + data.message);
                }
            })
            .catch(error => console.error('Errore:', error));
        });
    }
});
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".btn-qty").forEach(btn => {
        btn.addEventListener("click", function() {
            const id = this.getAttribute("data-id");
            const action = this.getAttribute("data-action"); // 'plus' o 'minus'

            // Chiamata AJAX alla Servlet
            fetch(`CarrelloServlet?action=${action}&id=${id}`, { method: 'POST' })
                .then(response => response.json()) // Assicurati che la Servlet ritorni JSON
                .then(data => {
                    if (data.success) {
                        // Aggiorna solo il numero visibile a schermo
                        const span = this.parentElement.querySelector(".quantity-value");
                        span.textContent = data.nuovaQuantita;
                        
                        // Se la quantità arriva a 0, potresti voler rimuovere la riga
                        if (data.nuovaQuantita <= 0) {
                            this.closest('.single-cart-element').remove();
                        }
                    } else {
                        alert("Errore aggiornamento!");
                    }
                })
                .catch(err => console.error(err));
        });
    });
});
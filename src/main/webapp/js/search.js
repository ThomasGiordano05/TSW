document.addEventListener("DOMContentLoaded", () => {
  
    const searchBar = document.getElementById("barraRicerca");

    if (searchBar) {
        searchBar.addEventListener("input", () => {
            const text = searchBar.value.toLowerCase();

            document.querySelectorAll(".grid-elements").forEach(card => {
                const nameProductElem = card.querySelector(".name-product");
                
                if (nameProductElem) {
                    const name = nameProductElem.textContent.toLowerCase();

                    if (name.includes(text)) {
                        card.style.display = "flex";   // Mostra se corrisponde
                    } else {
                        card.style.display = "none";   // Nasconde se non corrisponde
                    }
                }
            });
        });
    }

    const shadow = document.querySelector(".all-shadow");
    const container = document.querySelector(".container-shop");
    const closeBtn = document.getElementById("close-shop");

    function chiudi() {
        if (shadow) shadow.style.display = "none";
        if (container) container.style.display = "none";
    }

    if (closeBtn) {
        closeBtn.addEventListener("click", chiudi);
    }

    if (shadow) {
        shadow.addEventListener("click", (e) => {
            if (e.target === shadow) { 
                chiudi();
            }
        });
    }

    const btnCheckout = document.querySelector(".button-checkout");

    if (btnCheckout) {
        btnCheckout.addEventListener("click", () => {
            fetch('CheckoutServlet', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Ordine effettuato con successo! Grazie per aver scelto PokéCave.");
                    window.location.href = "Index.jsp";
                } else {
                    alert("Errore durante il checkout: " + data.message);
                }
            })
            .catch(error => console.error('Errore:', error));
        });
    }

    const bottoniAcquista = document.querySelectorAll(".cart_shop");

    bottoniAcquista.forEach(btn => {
        btn.addEventListener("click", function() {
            const idPokemon = this.getAttribute("data-id");

            fetch('CarrelloServlet?action=add&id=' + idPokemon, {
                method: 'POST'
            })
            .then(response => {
                if (shadow && container) {
                    shadow.style.display = "block";
                    container.style.display = "block";
                }
            })
            .catch(error => {
                console.error("Errore nell'aggiunta al carrello:", error);
                alert("Errore! Riprova più tardi.");
            });
        });
    });
});
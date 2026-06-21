document.addEventListener("DOMContentLoaded", () => {
    const searchBar = document.getElementById("barraRicerca");
    const suggerimentiBox = document.getElementById("risultati-suggerimenti");

    if (searchBar) {
        searchBar.addEventListener("input", () => {
            const text = searchBar.value.toLowerCase();

            // Filtro visivo sulle card già presenti nella pagina (Client-side)
            document.querySelectorAll(".grid-elements").forEach(card => {
                const nameProductElem = card.querySelector(".name-product");
                if (nameProductElem) {
                    const name = nameProductElem.textContent.toLowerCase();
                    card.style.display = name.includes(text) ? "flex" : "none";
                }
            });

            // Ricerca AJAX per i suggerimenti (Server-side)
            if (text.length >= 3) {
                fetch('CercaProdottoServlet?ajax=true&testoCercato=' + encodeURIComponent(text))
                    .then(response => response.json())
                    .then(data => {
                        suggerimentiBox.innerHTML = ""; // Pulisce i suggerimenti precedenti

                        data.forEach(p => {
                            const item = document.createElement("div");
                            item.className = "suggerimento-item";
                            item.textContent = p.nome;
                            
                            // Click sul suggerimento: reindirizza alla ricerca completa
                            item.onclick = () => {
                                window.location.href = "CercaProdottoServlet?testoCercato=" + encodeURIComponent(p.nome);
                            };
                            
                            suggerimentiBox.appendChild(item);
                        });
                    })
                    .catch(err => console.error("Errore AJAX:", err));
            } else {
                // Pulisce se l'utente cancella o scrive meno di 3 caratteri
                if (suggerimentiBox) suggerimentiBox.innerHTML = "";
            }
        });
    }

    const shadow = document.querySelector(".all-shadow");
    const container = document.querySelector(".container-shop");
    const closeBtn = document.getElementById("close-shop");

    function chiudi() {
        if (shadow) shadow.style.display = "none";
        if (container) container.style.display = "none";
    }

    if (closeBtn) closeBtn.addEventListener("click", chiudi);

    if (shadow) {
        shadow.addEventListener("click", (e) => {
            if (e.target === shadow) chiudi();
        });
    }

    // --- Logica Checkout ---
    const btnCheckout = document.querySelector(".button-checkout");
    if (btnCheckout) {
        btnCheckout.addEventListener("click", () => {
            fetch('CheckoutServlet', { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert("Ordine effettuato con successo!");
                        window.location.href = "Index.jsp";
                    } else {
                        alert("Errore: " + data.message);
                    }
                });
        });
    }

    const bottoniAcquista = document.querySelectorAll(".cart_shop");
    bottoniAcquista.forEach(btn => {
        btn.addEventListener("click", function() {
            const idPokemon = this.getAttribute("data-id");
            fetch('CarrelloServlet?action=add&id=' + idPokemon, { method: 'POST' })
                .then(() => {
                    if (shadow && container) {
                        shadow.style.display = "block";
                        container.style.display = "block";
                    }
                });
        });
    });
    document.addEventListener("click", (e) => {
        const box = document.getElementById("risultati-suggerimenti");
        const input = document.getElementById("barraRicerca");
        
        // Se il click avviene FUORI dall'input e FUORI dalla tendina, nascondi la tendina
        if (e.target !== input && e.target !== box) {
            if (box) box.innerHTML = "";
        }
    });
});
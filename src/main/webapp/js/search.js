document.addEventListener("DOMContentLoaded", () => {
    const searchBar = document.getElementById("barraRicerca");
    const suggerimentiBox = document.getElementById("risultati-suggerimenti");

    if (searchBar) {
        searchBar.addEventListener("input", () => {
            const text = searchBar.value.toLowerCase();

            //filtro visivo sulle card già presenti nella pagina (Client-side)
            document.querySelectorAll(".grid-elements").forEach(card => {
                const nameProductElem = card.querySelector(".name-product");
                if (nameProductElem) {
                    const name = nameProductElem.textContent.toLowerCase();
                    card.style.display = name.includes(text) ? "flex" : "none";
                }
            });

            //ricerca AJAX per i suggerimenti (Server-side)
            if (text.length >= 3) {
                fetch('CercaProdottoServlet?ajax=true&testoCercato=' + encodeURIComponent(text))
                    .then(response => response.json())
                    .then(data => {
                        suggerimentiBox.innerHTML = ""; //pulisce i suggerimenti precedenti

                        data.forEach(p => {
                            const item = document.createElement("div");
                            item.className = "suggerimento-item";
                            item.textContent = p.nome;
                            
                            item.onclick = () => {
                                window.location.href = "CercaProdottoServlet?testoCercato=" + encodeURIComponent(p.nome);
                            };
                            
                            suggerimentiBox.appendChild(item);
                        });
                    })
                    .catch(err => console.error("Errore AJAX:", err));
            } else {
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
//checkout
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
        
        
        if (e.target !== input && e.target !== box) {
            if (box) box.innerHTML = "";
        }
    });
});
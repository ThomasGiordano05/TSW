document.addEventListener("DOMContentLoaded", () => {
    // Se contextPath non è definito, usiamo una stringa vuota
    const path = (typeof contextPath !== 'undefined') ? contextPath : "";

    document.querySelectorAll(".btn-qty").forEach(btn => {
        btn.addEventListener("click", function(e) {
            e.preventDefault();
            
            const btn = this;
            const id = btn.getAttribute("data-id");
            const action = btn.getAttribute("data-action");
            const container = btn.closest('.single-cart-element');
            const qtyDiv = container.querySelector(".quantity-value");

            // URL COMPLETO: stampalo nella console per debug
            const url = path + "/CarrelloServlet?action=" + action + "&id=" + id;
            console.log("Chiamata a:", url); 
            
            fetch(url)
                .then(res => {
                    if (!res.ok) throw new Error("Errore HTTP: " + res.status);
                    return res.json();
                })
                .then(data => {
                    if (data.success) {
                        if (qtyDiv) qtyDiv.innerText = data.nuovaQuantita;
                        const totaleSpan = document.getElementById("totale-complessivo");
                        if (totaleSpan) {
                            totaleSpan.innerText = "€" + data.nuovoTotale.toFixed(2);
                        }
                        if (data.nuovaQuantita <= 0) {
                            container.remove();
                        }
                    }
                })
                .catch(err => {
                    console.error("Errore AJAX:", err);
                    alert("Errore! Controlla la console.");
                });
        });
    });
});
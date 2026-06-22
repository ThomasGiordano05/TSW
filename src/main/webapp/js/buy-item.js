document.addEventListener("DOMContentLoaded", () => {
    const bottoniAcquista = document.querySelectorAll(".cart_shop");

    bottoniAcquista.forEach(btn => {
        btn.addEventListener("click", function() {
            
            const idPokemon = this.getAttribute("data-id");

           
            fetch('CarrelloServlet?action=add&id=' + idPokemon, {
                method: 'POST'
            })
            .then(response => {
                document.querySelector(".all-shadow").style.display = "block";
                document.querySelector(".container-shop").style.display = "block";
            })
        });
    });
});
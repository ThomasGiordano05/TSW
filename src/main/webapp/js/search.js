const searchBar = document.getElementById("search-bar");

searchBar.addEventListener("input", () => {
    const text = searchBar.value.toLowerCase();

    document.querySelectorAll(".grid-elements").forEach(card => {
        const name = card.querySelector(".name-product").textContent.toLowerCase();

        if (name.includes(text)) {
            card.style.display = "flex";   // mostra
        } else {
            card.style.display = "none";   // nasconde
        }
    });
});
